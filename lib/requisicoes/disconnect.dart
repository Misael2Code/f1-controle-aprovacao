import 'package:controle_aprovacao/model/Model_DNS.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/requisicoes/Rest_ValidarDNS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Disconnect {
  void disconnect() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    Model_Parametro par = Model_Parametro();
    p.clear();
    Model_DNS().DNS = '';
    par.Cli = '';
    par.Url = '';
    ResultadoDNS().conectado = false;
  }
}