import 'package:ControleAprovacao/model/Model_Usuario.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Rotinas.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class Autenticar {
  static bool _conectado = false;
  static String _resultado = '';

  bool get conectado => _conectado;

  set conectado(bool value) {
    _conectado = value;
  }

  String get resultado => _resultado;

  set resultado(String value) {
    _resultado = value;
  }
}

Future<bool> autenticacao(
    String codCli, String webLog, String username, String password) async {
  Model_Usuario usu = Model_Usuario();

  usu.SetUsername = username;
  usu.SetPassword = password;

  // bool certificateCheck(X509Certificate cert, String host, int port) => true;
  //
  // http.Client httpsClient() {
  //   var ioClient = HttpClient()..badCertificateCallback = certificateCheck;
  //   return IOClient(ioClient);
  // }

  webLog = '$webLog/g5-senior-services/sapiens_SyncMCWFUsers?wsdl';

 
  final response = await http.post(
    Uri.parse(webLog),
    headers: {'Content-Type': 'text/xml;charset=UTF-8'},
    body: '''
         <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">\r\n
           <soapenv:Header/>\r\n
           <soapenv:Body>\r\n
              <ser:AuthenticateJAAS>\r\n
                 <user>$username</user>\r\n
                 <password>$password</password>\r\n
                 <encryption>0</encryption>\r\n
                 <parameters>\r\n
                    <pmEncrypted>0</pmEncrypted>\r\n
                    <pmUserName>$username</pmUserName>\r\n
                    <pmUserPassword>$password</pmUserPassword>\r\n
                 </parameters>\r\n
              </ser:AuthenticateJAAS>\r\n
           </soapenv:Body>\r\n
        </soapenv:Envelope>
      ''',
  );

  

  // Verifique o código de status da resposta para determinar se o login foi bem-sucedido.
  if (response.statusCode == 200) {
    final parsedXml = xml.XmlDocument.parse(response.body);
    final pmLogged = parsedXml.findAllElements('pmLogged').single.toString();
    // Se o login foi bem-sucedido, conecta no app.
    if (pmLogged.contains('0')) {
      debugPrint("Login bem-sucedido");

      Autenticar().conectado = true;

      await BuscarRotinas();
      await BuscarUsuario();

      return Future.value(true);
    } else {
      Autenticar().resultado =
          'Desculpe! Não foi possível conectar com as credenciais informadas.';
      return Future.value(false);
    }
  } else {
    Autenticar().resultado = 'Falha na Conexão!';
    return Future.value(false);
  }
}
