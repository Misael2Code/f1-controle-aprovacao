import 'package:ControleAprovacao/initialized.dart';
import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/paginas/Controles.dart';
import 'package:ControleAprovacao/paginas/Login.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Autenticar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _loginAutomatic(context); // Chamar login automático na inicialização
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(2),
          height: 60,
          child: Image.asset('image/logo.png'),
        ),
      ),
    );
  }

  Future<void> _loginAutomatic(BuildContext context) async {
    // Inicializar as configurações necessárias
    await Initialized();

    // Recuperar credenciais armazenadas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('LOGIN_USER') ?? '';
    String pass = prefs.getString('LOGIN_PASS') ?? '';

    // Verificar se as credenciais são válidas
    if (user.isNotEmpty && pass.isNotEmpty) {
      bool authenticated = await autenticacao(
        Model_Parametro().GetCli,
        Model_Parametro().GetUrl,
        user,
        pass,
      );

      // Navegar para a página de controle se autenticado
      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Controles(setRot: 0)),
        );
      } else {
        _navigateToLogin(context);
      }
    } else {
      _navigateToLogin(context);
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}
