import 'package:ControleAprovacao/components/ShowDialog.dart';
import 'package:ControleAprovacao/model/Model_Firebase.dart';
import 'package:ControleAprovacao/paginas/Controles.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Autenticar.dart';
import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_DNS.dart';
import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/model/Model_Usuario.dart';
import 'package:ControleAprovacao/requisicoes/Rest_ValidarDNS.dart';
import 'package:ControleAprovacao/requisicoes/set_Memory.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

  static late final _context;

  get getContext => _context;

  set context(final value) {
    _context = value;
  }
}

class _LoginState extends State<Login> {
  Model_Usuario usu = Model_Usuario();
  Model_Parametro param = Model_Parametro();
  Model_DNS dns = Model_DNS();

  final _sizeLogo = 70.0;
  final _controllerUser = TextEditingController();
  final _controllerPass = TextEditingController();
  final _controllerDNS = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: IconButton(
              onPressed: () {
                dns.DNS.isEmpty
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Informe o endereço DNS'),
                            content: TextFormField(
                              controller: _controllerDNS,
                              decoration: const InputDecoration(
                                  hintText:
                                      'Exemplo: https://nome_servidor:porta'),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () async {
                                    dns.DNS = _controllerDNS.text;
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) =>
                                            const AlertDialog(
                                              content: Row(
                                                children: [
                                                  CircularProgressIndicator()
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                            ));
                                    if (Model_Firebase()
                                        .dns
                                        .contains(_controllerDNS.text)) {
                                      param.Url = _controllerDNS.text;
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                      ResultadoDNS().conectado = true;
                                      Model_Parametro().Url =
                                          _controllerDNS.text;
                                      setMemory(_controllerDNS.text);
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Atenção!'),
                                              content: const Text(
                                                  'O servidor informado não consta em nosso banco de dados. Por favor, entre em contato conosco.'),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      dns.DNS = '';
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Login()));
                                                    },
                                                    child: const Text('OK'))
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: const Text('Salvar'))
                            ],
                          );
                        })
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Aviso'),
                            content: Wrap(
                              children: [
                                const Text('O endereço '),
                                Text(
                                  Model_Parametro().GetUrl,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                    ' já está conectado. Deseja alterar?')
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Informe o endereço DNS'),
                                            content: TextFormField(
                                              controller: _controllerDNS,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'Exemplo: nome_servidor:porta'),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    dns.DNS =
                                                        _controllerDNS.text;
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                                context) =>
                                                            const AlertDialog(
                                                              content: Row(
                                                                children: [
                                                                  CircularProgressIndicator()
                                                                ],
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                              ),
                                                            ));
                                                    if (Model_Firebase()
                                                        .dns
                                                        .contains(_controllerDNS
                                                            .text)) {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Login()));
                                                      ResultadoDNS().conectado =
                                                          true;
                                                      Model_Parametro().Url =
                                                          _controllerDNS.text;
                                                      setMemory(
                                                          _controllerDNS.text);
                                                    } else {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Atenção!'),
                                                              content: const Text(
                                                                  'O servidor informado não consta em nosso banco de dados. Por favor, entre em contato conosco.'),
                                                              actions: [
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      dns.DNS =
                                                                          '';
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const Login()));
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'OK'))
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  },
                                                  child: const Text('Salvar'))
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('Alterar')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Não')),
                            ],
                          );
                        });
              },
              icon: Icon(
                Icons.settings,
                color: ResultadoDNS().conectado
                    ? Colors.lightGreenAccent
                    : Colors.white,
              )),
        ),
        elevation: 32,
        backgroundColor: const Color.fromRGBO(0, 74, 173, 100),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: 320,
            decoration: const BoxDecoration(
              color: Colors.white24,
            ),
            child: Column(
              children: [
                Model_Parametro().GetUrl.isEmpty
                    ? const Center(
                        child: Column(
                        children: [
                          Text(
                            'Servidor não Conectado! ',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            children: [
                              Text(
                                'Clique no botão ',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                              Icon(
                                Icons.settings,
                                color: Colors.red,
                              ),
                              Text(
                                ' para configurar um servidor.',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ))
                    : const Text(''),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset('image/logo.png'),
                        height: _sizeLogo,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 38, right: 38),
                        child: const SizedBox(
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.blueGrey),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, bottom: 16, top: 6),
                        child: const Text(
                          "CONTROLE DE APROVAÇÃO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _controllerUser,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.supervisor_account_sharp,
                              color: Colors.blueGrey,
                            ),
                            label: Text('Usuário'),
                            hintText: 'Digite seu usuário',
                            hintStyle: TextStyle(fontSize: 12)),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _controllerPass,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock_person,
                              color: Colors.blueGrey,
                            ),
                            label: Text('Senha'),
                            hintText: 'Digite sua senha',
                            hintStyle: TextStyle(fontSize: 12)),
                      ),
                      const SizedBox(height: 22),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(0, 74, 173, 100)),
                          onPressed: () async {
                            bool form = await validarForm();
                            if (form) {
                              DialogHelper.showConnecting(
                                  context, 'Conectando...');
                              bool connect = await Autenticacao(
                                  Model_Parametro().GetCli,
                                  Model_Parametro().GetUrl,
                                  _controllerUser.text,
                                  _controllerPass.text);
                              if (connect) {
                                setUserMemory(
                                    _controllerUser.text, _controllerPass.text);
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              } else {
                                Navigator.of(context).pop();
                                DialogHelper.showLoginFailed(
                                    context, 'Falha no Login!');
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Autenticar',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(
                        height: 65,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: const Column(
                            children: [
                              Text('from:',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 8,
                                      color: Colors.grey)),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'F1 Tecnologia e Consultoria Ltda.',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> validarForm() async {
    if (Model_DNS().DNS.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Atenção!'),
            content: const Text(
                'Não é possível conectar sem informar o "servidor:porta" para acesso.'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return Future.value(false);
    } else if ((_controllerUser.text == '') || (_controllerPass.text == '')) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Dados Incompletos'),
            content: const Text('Por favor, informe usuário e senha'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return Future.value(false);
    } else
      return Future.value(true);
  }
}
