import 'package:controle_aprovacao/paginas/Servidor.dart';
import 'package:controle_aprovacao/requisicoes/disconnect.dart';
import 'package:controle_aprovacao/welcome.dart';
import 'package:flutter/material.dart';
import 'package:controle_aprovacao/components/ShowDialog.dart';
// import 'package:controle_aprovacao/model/Model_Firebase.dart';
import 'package:controle_aprovacao/paginas/Controles.dart';
import 'package:controle_aprovacao/requisicoes/Rest_Autenticar.dart';
import 'package:controle_aprovacao/model/Model_DNS.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/requisicoes/set_Memory.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Model_Parametro _parametro = Model_Parametro();
  final Model_DNS _dns = Model_DNS();
  final double _sizeLogo = 70.0;
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  bool isLoading = false;
  bool isDisconnecting = false;
  bool obscureTextUser = false;
  bool obscureTextPass = true;
  String erroTextUser = '';
  String erroTextPass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: () {
          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
              title: const Text('Deseja desconectar?'),
              content: const Text(
                  'Ao desconectar os dados do servidor serão apagados.'),
              actions: [
                TextButton(
                    onPressed: () =>
                        Navigator.pop(context, 'Não'),
                    child: const Text('Não')),
                isDisconnecting ? const CircularProgressIndicator() : TextButton(
                    onPressed: () async {
                      setState(() {
                        isDisconnecting = true;
                      });
                        Disconnect().disconnectServer();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Servidor()));
                    },
                    child: const Text('Sair'))
              ],
            ));           
        },
        icon: const Icon(Icons.power_settings_new, color: Colors.red,)
        )
      ],)),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          spreadRadius: 1,
                          blurRadius: 9,
                          offset: Offset(0, 4),
                        ),
                      ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('image/logo.png', height: _sizeLogo),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                    child: Text("CONTROLE DE APROVAÇÃO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 14,)),
                  ),
                  const SizedBox(height: 4),
                  _buildTextField(_controllerUser, Icons.supervisor_account_sharp,
                      'Usuário', 'Digite seu usuário'),
                      const SizedBox(height: 12),
                  _buildTextField(_controllerPass, Icons.lock_person, 'Senha',
                      'Digite sua senha'),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        backgroundColor: const Color.fromRGBO(13, 71, 161, 1)),
                    onPressed: ()  {
                        if(_controllerUser.text.isEmpty) {
                          setState(() {
                            erroTextUser = "Informe um Usuário";  
                            if(_controllerPass.text.isEmpty) {
                              erroTextPass = "Informe uma Senha";
                            }
                          });                        
                        }
                        else if(_controllerPass.text.isEmpty) {
                          erroTextPass = "Informe uma Senha";
                        } else {
                          erroTextUser = '';
                          erroTextPass = '';
                          setState(() {
                            isLoading = true; 
                          });                        
                          _authenticateUser(context);}
                        },
                    child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: isLoading ? Transform.scale(scale: 0.5, 
                          child: const CircularProgressIndicator(color: Colors.white,)) : 
                          const Text('Conectar',
                            style: TextStyle(color: Colors.white))),
                  ),                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
  TextEditingController controller,
  IconData iconData,
  String labelText,
  String hintText
) {
  late String textError;
  switch(labelText) {
    case 'Usuário':
      textError = erroTextUser;      
      break;
    case 'Senha':
      textError = erroTextPass;
  }

  return TextFormField(
    controller: controller,
    obscureText: labelText.contains('Usuário') ? obscureTextUser : obscureTextPass,
    decoration: InputDecoration(
      errorText: textError.isEmpty ? null : textError,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
      prefixIcon: Icon(
        iconData,
        color: Colors.blue,
      ),
      label: Text(labelText),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 12),      
      suffixIcon: labelText.contains('Senha')
          ? IconButton(
              icon: Icon(
                obscureTextPass ? Icons.visibility_off : Icons.visibility,
                color: Colors.blueAccent,
              ),              
              onPressed: () {
                setState(() {
                  obscureTextPass = !obscureTextPass;
                });
              },
            )
          : null, // Caso não seja um campo de senha, não exibe o ícone
    ),
  );
}

  Future<void> _authenticateUser(BuildContext context) async {      
      //DialogHelper.showConnecting(context, 'Conectando...');
      bool connect = await autenticacao(_parametro.GetCli, _parametro.GetUrl,
          _controllerUser.text, _controllerPass.text);

      if (connect) {
        setUserMemory(_controllerUser.text, _controllerPass.text);
        //Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Controles(setRot: 0)));
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });   
         setState(() {
           erroTextUser = 'Usuário ou senha incorretos';
           erroTextPass = 'Usuário ou senha incorretos';
           isLoading = false;
         });    
      }      
  }

  Future<void> _showAlertDialog(String title, String content) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]);
        });
  }
}
