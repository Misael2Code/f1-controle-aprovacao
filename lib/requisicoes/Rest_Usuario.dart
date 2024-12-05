import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/model/Model_Usuario.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

Future<void> BuscarUsuario() async {
  Model_Parametro param = Model_Parametro();
  Model_Usuario usu = Model_Usuario();

  String url =
      '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_f1_ControleAprovacao_Rotinas?wsdl';

  // Use o pacote http para fazer uma chamada SOAP para o serviço web.
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'text/xml; charset=UTF-8'},
    body: '''       
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
            <soapenv:Body>
              <ser:Usuario>
                <user>${usu.username}</user>
                <password>${usu.password}</password>
                <encryption>0</encryption>
                <parameters>
                  <nomUsu>${usu.username}</nomUsu>
                </parameters>
              </ser:Usuario>
            </soapenv:Body>
          </soapenv:Envelope>

      ''',
  );

  if (response.statusCode == 200) {
    final body = response.body;
    final parsedXml = xml.XmlDocument.parse(body);

    final CodUsu = parsedXml.findAllElements('codUsu').single.text;
    Model_Usuario().codUsu = CodUsu;
  }
}
