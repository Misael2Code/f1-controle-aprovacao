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
  State<Welcome> createState() => _welcomeState();
}

class _welcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    loginAutomatic(context);

    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(2),
        child: Image.asset('image/logo.png'),
        height: 60,
      ),
    ));
  }
}

void loginAutomatic(BuildContext context) async {
  await Initialized();

  SharedPreferences p = await SharedPreferences.getInstance();
  var user = p.getString('LOGIN_USER').toString();
  var pass = p.getString('LOGIN_PASS').toString();
  user.contains('null') ? user = '' : user = user;
  pass.contains('null') ? pass = '' : pass = pass;

  if ((user.isNotEmpty) || (pass.isNotEmpty)) {
    bool connect = await Autenticacao(
        Model_Parametro().GetCli, Model_Parametro().GetUrl, user, pass);
    if (connect) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Controles()));
    }
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
