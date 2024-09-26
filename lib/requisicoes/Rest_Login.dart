import 'package:http/http.dart' as http;

Future<bool> Autenticacao(
    String codCli, String webLog, String username, String password) async {
  var webLog = 'https://exemplo.com';
  var url = '$webLog/g5-senior-services/sapiens_SyncMCWFUsers?wsdl';

  try {
    // Configuração para ignorar a verificação do certificado
    var client = http.Client();
    // ..badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => true;

    var response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'text/xml;charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body:
          '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">\r\n
            <soapenv:Header/>\r\n
            <soapenv:Body>\r\n
               <ser:AuthenticateJAAS>\r\n
                  <user>${username}</user>\r\n
                  <password>${password}</password>\r\n
                  <encryption>0</encryption>\r\n
                  <parameters>\r\n
                     <pmEncrypted>0</pmEncrypted>\r\n
                     <pmUserName>${username}</pmUserName>\r\n
                     <pmUserPassword>${password}</pmUserPassword>\r\n
                  </parameters>\r\n
               </ser:AuthenticateJAAS>\r\n
            </soapenv:Body>\r\n
         </soapenv:Envelope>''',
    );

    // Processar a resposta SOAP
    print(response.body);

    // Fechar o cliente após o uso
    client.close();
    return true;
  } catch (e) {
    print('Erro na requisição: $e');
    return false;
  }
}
