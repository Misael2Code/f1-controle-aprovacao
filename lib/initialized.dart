import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/requisicoes/set_Memory.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> Initialized() async {
  // await getAllDnsFirebase();
  await getMemoryDevice();
  await validation();
}

Future<void> validation() async {
  SharedPreferences p = await SharedPreferences.getInstance();
  var dns = p.getString('LOGIN_DNS').toString();
  dns.contains('null') ? Model_Parametro().Url = '' : null;
}
