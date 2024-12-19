import 'package:controle_aprovacao/model/Model_DNS.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/model/Model_Usuario.dart';
import 'package:controle_aprovacao/requisicoes/Rest_ValidarDNS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Disconnect {
  Future<void> disconnectUser() async {
    SharedPreferences p = await SharedPreferences.getInstance(); 
    p.remove('LOGIN_USER');   
    p.remove('LOGIN_PASS');   
    Model_Usuario().SetUsername = '';
    Model_Usuario().SetPassword = '';   
  }

  Future<void> disconnectServer() async {
    SharedPreferences p = await SharedPreferences.getInstance(); 
    p.clear();   
    ResultadoDNS().conectado = false;    
    Model_Parametro().clear();
    Model_DNS().DNS = '';     
    Model_Usuario().SetPassword = '';
    Model_Usuario().SetUsername = '';
  }
}