import 'package:flutter/material.dart';
import 'package:controle_aprovacao/components/ShowDialog.dart';
// import 'package:controle_aprovacao/model/Model_Firebase.dart';
import 'package:controle_aprovacao/paginas/Controles.dart';
import 'package:controle_aprovacao/requisicoes/Rest_Autenticar.dart';
import 'package:controle_aprovacao/model/Model_DNS.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/requisicoes/Rest_ValidarDNS.dart';
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
  final TextEditingController _controllerDNS = TextEditingController();
  bool obscureTextUser = false;
  bool obscureTextPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: IconButton(
            icon: Icon(
              Icons.settings,
              color: ResultadoDNS().conectado
                  ? Colors.lightGreenAccent
                  : Colors.white,
            ),
            onPressed: () => _showDNSDialog(context),
          ),
        ),
        elevation: 32,
        backgroundColor: const Color.fromRGBO(0, 74, 173, 100),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(100)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 320,
            decoration: const BoxDecoration(color: Colors.white24),
            child: Column(
              children: [
                if (_parametro.GetUrl.isEmpty) ...[
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text('Servidor não Conectado!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(height: 8),
                      Wrap(
                        children: [
                          Text('Clique no botão ',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                          Icon(Icons.settings, color: Colors.red),
                          Text(' para configurar um servidor.',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        ],
                      )
                    ],
                  )
                ],
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(12),
                  child: Image.asset('image/logo.png', height: _sizeLogo),
                ),
                const SizedBox(height: 2),
                const Divider(color: Colors.blueGrey),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                  child: Text("CONTROLE DE APROVAÇÃO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.blueGrey,
                          fontSize: 14)),
                ),
                const SizedBox(height: 4),
                _buildTextField(_controllerUser, Icons.supervisor_account_sharp,
                    'Usuário', 'Digite seu usuário'),
                _buildTextField(_controllerPass, Icons.lock_person, 'Senha',
                    'Digite sua senha'),
                const SizedBox(height: 22),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 74, 173, 100)),
                  onPressed: () => _authenticateUser(context),
                  child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Conectar',
                          style: TextStyle(color: Colors.white))),
                ),
                const SizedBox(height: 65),
                Container(
                  alignment: Alignment.center,
                  child: const Column(children: [
                    Text('from:',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 8,
                            color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('F1 Tecnologia e Consultoria Ltda.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey))
                  ]),
                )
              ],
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

  return TextFormField(
    controller: controller,
    obscureText: labelText.contains('Usuário') ? obscureTextUser : obscureTextPass,
    decoration: InputDecoration(
      icon: Icon(
        iconData,
        color: Colors.blueAccent,
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


  Future<void> _showDNSDialog(BuildContext context) async {
    if (_dns.DNS.isEmpty) {
      await _showInputDialog(context);
    } else {
      await _showChangeDNSDialog(context);
    }
  }

  Future<void> _showInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informe o Servidor'),
          content: TextFormField(
            controller: _controllerDNS,
            decoration: const InputDecoration(
                hintText: 'Ex.: https://nome_servidor:porta'),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async => await _saveDNS(context),
                child: const Text('Salvar')),
          ],
        );
      },
    );
  }

  Future<void> _showChangeDNSDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: Wrap(children: [
            const Text('O endereço '),
            Text(_parametro.GetUrl,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text(' já está conectado. Deseja alterar?')
          ]),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Não')),
            ElevatedButton(
                onPressed: () => _showInputDialog(context),
                child: const Text('Alterar')),
          ],
        );
      },
    );
  }

  Future<void> _saveDNS(BuildContext context) async {
    // Show loading dialog
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const AlertDialog(
              content: Row(
                children: [CircularProgressIndicator()],
              ),
            ));
    //Validate DNS
    //if (Model_Firebase().dns.contains(_controllerDNS.text)) {
    // Save DNS and navigate
    ResultadoDNS().conectado = true;
    _dns.DNS = _controllerDNS.text;
    _parametro.Url = _controllerDNS.text;
    Navigator.pop(context);
    setMemory(_controllerDNS.text);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
    // } else {
    //   Navigator.pop(context);
    //  await _showErrorDialog(context);
    // }
  }

  Future<void> _showErrorDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção!'),
          content: const Text(
              'O servidor informado não consta em nosso banco de dados. Por favor, entre em contato conosco.'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK')),
          ],
        );
      },
    );
  }

  Future<void> _authenticateUser(BuildContext context) async {
    bool formValid = await validateForm();
    if (formValid) {
      DialogHelper.showConnecting(context, 'Conectando...');
      bool connect = await autenticacao(_parametro.GetCli, _parametro.GetUrl,
          _controllerUser.text, _controllerPass.text);

      if (connect) {
        setUserMemory(_controllerUser.text, _controllerPass.text);
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Controles(setRot: 0)));
      } else {
        Navigator.of(context).pop();
        DialogHelper.showLoginFailed(context, 'Falha no Login!');
      }
    }
  }

  Future<bool> validateForm() async {
    if (_dns.DNS.isEmpty) {
      await _showAlertDialog('Atenção!',
          'Não é possível conectar sem informar o "servidor:porta" para acesso.');
      return false;
    } else if (_controllerUser.text.isEmpty || _controllerPass.text.isEmpty) {
      await _showAlertDialog(
          'Dados Incompletos', 'Por favor, informe usuário e senha');
      return false;
    }
    return true;
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
