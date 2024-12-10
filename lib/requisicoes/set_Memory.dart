import 'package:ControleAprovacao/model/Model_DNS.dart';
import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/model/Model_Usuario.dart';
import 'package:ControleAprovacao/requisicoes/Rest_ValidarDNS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Set and get of DNS in memory
Future<bool> getMemoryDevice() async {
  late bool isNotEmpty;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString('LOGIN_DNS').toString() == 'null') {
    Model_DNS().DNS = '';
    isNotEmpty = false;
  } else {
    ResultadoDNS().conectado = true;
    Model_DNS().DNS = preferences.getString('LOGIN_DNS').toString();
    Model_Parametro().Cli = preferences.getString('LOGIN_CLI').toString();
    Model_Parametro().Url = preferences.getString('LOGIN_DNS').toString();
    Model_Usuario().SetUsername =
        preferences.getString('LOGIN_USER').toString();
    Model_Usuario().SetPassword =
        preferences.getString('LOGIN_PASS').toString();
    isNotEmpty = true;
  }
  return isNotEmpty;
}

void setMemory(String dns) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // set DNS in memory
  prefs.setString("LOGIN_DNS", dns);
  

  //Set client in memory
  FirebaseFirestore.instance.collection('users').get().then((querySnapshot) {
    
    

    for (var docSnapshot in querySnapshot.docs) {
      debugPrint(docSnapshot.data().toString());

      Model_Parametro().Cli = docSnapshot.data().remove(dns);
      debugPrint("Cliente salvo:" + Model_Parametro().GetCli);
      prefs.setString("LOGIN_CLI", Model_Parametro().GetCli);
    }
  });
}

// Set an get of user/pass in memory
void setUserMemory(String user, String pass) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('LOGIN_USER', user);
  prefs.setString('LOGIN_PASS', pass);
}
