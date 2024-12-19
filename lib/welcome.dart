import 'package:controle_aprovacao/initialized.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/paginas/Controles.dart';
import 'package:controle_aprovacao/paginas/Login.dart';
import 'package:controle_aprovacao/paginas/Servidor.dart';
import 'package:controle_aprovacao/requisicoes/Rest_Autenticar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String _stateStart = 'Iniciando a aplicação...';

  @override
  void initState() {
    super.initState();
    _loginAutomatic(context); // Chamar login automático na inicialização

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(12),
                child: Image.asset('image/logo.png', height: 70),
              ),
              const LinearProgressIndicator(color: Colors.blue, 
              backgroundColor: Color.fromRGBO(2, 15, 31, 1),),
              Text(_stateStart, style: const TextStyle(color: Colors.black),),
          ],
        ),
      ),
    );
  }

  Future<void> _loginAutomatic(BuildContext context) async {
  // Exibe e aguarda 500ms
  await statusInicialization('Verificando servidor...');
  await Initialized();

  // Exibe e aguarda 500ms
  await statusInicialization('Procurando usuário e senha...');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String user = prefs.getString('LOGIN_USER') ?? '';
  String pass = prefs.getString('LOGIN_PASS') ?? '';

  if (user.isNotEmpty && pass.isNotEmpty) {
    // Exibe e aguarda 500ms
    await statusInicialization('Usuário encontrado. Conectando...');
    bool authenticated = await autenticacao(
      Model_Parametro().GetCli,
      Model_Parametro().GetUrl,
      user,
      pass,
    );

    if (authenticated) {
      // Exibe e aguarda 500ms antes de navegar
      await statusInicialization('Conectado! Carregando seus dados...');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Controles(setRot: 0)),
      );
    } else {
      // Exibe e aguarda 500ms antes de navegar
      await statusInicialization('Falha na conexão...');
      _navigateToLogin(context);
    }
  } else {
    // Exibe e aguarda 500ms antes de navegar
    await statusInicialization('Usuário não encontrado...');
    _navigateToLogin(context);
  }
}


  void _navigateToLogin(BuildContext context) async {
  if (Model_Parametro().GetUrl.isEmpty) {
    await statusInicialization('Carregando a tela inicial...');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Servidor()),
    );
  } else {
    await statusInicialization('Carregando a tela de login...');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}


  Future<void> statusInicialization(String status) async {   
    await Future.delayed(const Duration(milliseconds: 750));
    setState(() {
      _stateStart = status;
    });    
    await Future.delayed(const Duration(milliseconds: 750));

  }
}
