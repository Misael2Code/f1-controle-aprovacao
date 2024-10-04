import 'package:http/http.dart' as http;
import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/model/Model_Campos.dart';
import 'package:ControleAprovacao/model/Model_Usuario.dart';
import 'package:xml/xml.dart' as xml;

Future<List<Model_Campos>> fetchConsulta(String sitApr, String rotNap) async {
  Model_Usuario usu = Model_Usuario();
  Model_Parametro param = Model_Parametro();

  String url =
      '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_f1_ControleAprovacao_Rotinas?wsdl';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'text/xml; charset=UTF-8'},
    body: '''
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
            <soapenv:Body>
              <ser:Consulta>
                <user>${usu.username}</user>
                <password>${usu.password}</password>
                <encryption>0</encryption>
                <parameters>
                  <sitApr>${sitApr}</sitApr>
                  <rotNap>${rotNap}</rotNap>
                </parameters>
              </ser:Consulta>
            </soapenv:Body>
          </soapenv:Envelope>
      ''',
  );

  if (response.statusCode == 200) {
    final body = response.body;
    final parsedXml = xml.XmlDocument.parse(body);

    final items = parsedXml.findAllElements('retorno').map((element) {
      final RotDes = element.findElements('rotDes').single.text;
      final NumDoc = element.findElements('numDoc').single.text;
      final VlrApr = element.findElements('vlrApr').single.text;
      final NomEnt = element.findElements('nomEnt').single.text;
      final CodPro = element.findElements('codPro').single.text;
      final NomPro = element.findElements('nomPro').single.text;
      final CodSer = element.findElements('codSer').single.text;
      final NomSer = element.findElements('nomSer').single.text;
      final CodDer = element.findElements('codDer').single.text;
      final DatDoc = element.findElements('datDoc').single.text;
      final HorDoc = element.findElements('horDoc').single.text;
      final DatPrv = element.findElements('datPrv').single.text;
      final QtdDoc = element.findElements('qtdDoc').single.text;
      final UsuDoc = element.findElements('usuDoc').single.text;
      final VlrDsc = element.findElements('vlrDsc').single.text;
      final VlrPrs = element.findElements('vlrPrs').single.text;
      final CodEmp = element.findElements('codEmp').single.text;
      final DesCpg = element.findElements('desCpg').single.text;
      final SeqDoc = element.findElements('seqDoc').single.text;
      final UsuSol = element.findElements('usuSol').single.text;
      final UsuRes = element.findElements('usuRes').single.text;
      final CcuRes = element.findElements('ccuRes').single.text;
      final SeqEnt = element.findElements('seqEnt').single.text;
      final FilDoc = element.findElements('filDoc').single.text;
      return Model_Campos(
        rotDes: RotDes,
        numDoc: NumDoc,
        vlrApr: VlrApr,
        nomEnt: NomEnt,
        codPro: CodPro,
        nomPro: NomPro,
        codSer: CodSer,
        nomSer: NomSer,
        codDer: CodDer,
        datDoc: DatDoc,
        horDoc: HorDoc,
        datPrv: DatPrv,
        qtdDoc: QtdDoc,
        usuDoc: UsuDoc,
        vlrDsc: VlrDsc,
        vlrPrs: VlrPrs,
        desCpg: DesCpg,
        codEmp: CodEmp,
        seqDoc: SeqDoc,
        usuSol: UsuSol,
        usuRes: UsuRes,
        ccuRes: CcuRes,
        qtdEme: QtdDoc,
        seqEnt: SeqEnt,
        filDoc: FilDoc,
      );
    }).toList();

    return items;
  } else {
    throw Exception('Falha ao carregar os itens');
  }
}
