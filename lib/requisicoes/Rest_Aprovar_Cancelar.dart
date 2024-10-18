import 'package:http/http.dart' as http;
import 'package:ControleAprovacao/model/Model_Parametro.dart';
import 'package:ControleAprovacao/model/Model_Usuario.dart';
import 'package:xml/xml.dart' as xml;

Model_Usuario usu = Model_Usuario();
Model_Parametro param = Model_Parametro();

Future<String> Cotacao(
    int ind, String codEmp, String numCot, String seqCot, String codUsu) async {
  String url =
      '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_mcm_cpr_aprovarcotacoes?wsdl';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'text/xml; charset=UTF-8'},
    body: '''
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
            <soapenv:Body>
              <ser:AprovarCotacoes>
                <user>${usu.username}</user>
                <password>${usu.password}</password>
                <encryption>0</encryption>
                <parameters>
                  <gridCotacoes>
                    <aprCot>${ind.toString()}</aprCot>
                    <codEmp>$codEmp</codEmp>
                    <numCot>$numCot</numCot>
                    <seqCot>$seqCot</seqCot>
                    <codUsu>$codUsu</codUsu>
                    <codMot></codMot>
                    <obsMot></obsMot>
                    <datPrv></datPrv>
                  </gridCotacoes>
                </parameters>
              </ser:AprovarCotacoes>
            </soapenv:Body>
          </soapenv:Envelope>
      ''',
  );

  if (response.statusCode == 200) {
    late final resultado;
    final body = response.body;
    final parsedXml = xml.XmlDocument.parse(body);

    final tpResultado = parsedXml.findAllElements('tpResultado').single.text;
    final document = await xml.XmlDocument.parse(response.body);
    final list =
        await document.findAllElements('gridRetorno').map((node) async {
      resultado = await node
          .findElements('txtRet')
          .toString()
          .replaceAll('</txtRet>)', '')
          .replaceAll('(<txtRet>', '');
    }).toList();
    return tpResultado.contains('1') ? '1: execução sem erros' : resultado;
  } else {
    return 'Desculpe! Houve um erro de conexão';
  }
}

Future<String> Requisicao(int Ind, String CodEmp, String NumEme, String SeqEme,
    String CodUsu, String QtdEme) async {
  String url =
      '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_mcm_est_aprovarrequisicoes?wsdl';
  if (Ind == 1) {
    // Aprovar
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'text/xml; charset=UTF-8'},
      body: '''
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
              <soapenv:Body>
                <ser:AprovarRequisicoes>
                  <user>${usu.username}</user>
                  <password>${usu.password}</password>
                  <encryption>0</encryption>
                  <parameters>
                    <gridRequisicoes>
                      <codEmp>${CodEmp}</codEmp>
                      <numEme>${NumEme}</numEme>
                      <seqEme>${SeqEme}</seqEme>
                      <codUsu>${CodUsu}</codUsu>
                      <qtdEme>${QtdEme.replaceAll(RegExp(r','), '.')}</qtdEme>
                    </gridRequisicoes>
                  </parameters>
                </ser:AprovarRequisicoes>
              </soapenv:Body>
            </soapenv:Envelope>
      ''',
    );

    if (response.statusCode == 200) {
      late final txtRet;
      final body = response.body;
      final parsedXml = xml.XmlDocument.parse(body);
      final resultado = parsedXml.findAllElements('resultado').single.text;
      print('resultado: $resultado');
      final document = await xml.XmlDocument.parse(response.body);
      print('document: $document');
      final list =
          await document.findAllElements('gridRetorno').map((node) async {
        txtRet = await node
            .findElements('txtRet')
            .toString()
            .replaceAll('</txtRet>)', '')
            .replaceAll('(<txtRet>', '');
      }).toList();
      return resultado.contains('Processado com sucesso')
          ? '1: execução sem erros'
          : txtRet;
    } else {
      return 'Desculpe! Houve um erro de conexão';
    }
  } else if (Ind == 2) {
    // Cancelar
    String url =
        '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_mcm_est_requisicoes?wsdl';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'text/xml; charset=UTF-8'},
      body: '''
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
            <soapenv:Body>
              <ser:Cancelar>
                <user>${usu.username}</user>
                <password>${usu.password}</password>
                <encryption>0</encryption>
                <parameters>
                  <requisicoes>
                    <codEmp>${CodEmp}</codEmp>
                    <numEme>${NumEme}</numEme>
                    <seqEme>${SeqEme}</seqEme>
                  </requisicoes>
                </parameters>
              </ser:Cancelar>
            </soapenv:Body>
          </soapenv:Envelope>
      ''',
    );

    if (response.statusCode == 200) {
      late final resultado;
      final body = response.body;
      final parsedXml = xml.XmlDocument.parse(body);

      final tpResultado =
          parsedXml.findAllElements('tipoResultado').single.text;
      final document = await xml.XmlDocument.parse(response.body);
      final list = await document.findAllElements('erros').map((node) async {
        resultado = await node
            .findElements('txtRet')
            .toString()
            .replaceAll('</txtRet>)', '')
            .replaceAll('(<txtRet>', '');
      }).toList();
      return tpResultado.contains('1') ? '1: execução sem erros' : resultado;
    } else {
      return 'Desculpe! Houve um erro de conexão';
    }
  }
  return '';
}

Future<String> OrdemCompra(
    int ind, String seqOcp, String codEmp, String codFil, String numOcp) async {
  String url =
      '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_mcm_est_ordemcompra?wsdl';

  if (ind == 1) {
    // Aprovar
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'text/xml; charset=UTF-8'},
      body: '''
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
             <soapenv:Header/>
             <soapenv:Body>
                <ser:aprovar>
                   <user>${usu.username}</user>
                   <password>${usu.password}</password>
                   <encryption>0</encryption>
                   <parameters>
                      <flowInstanceID></flowInstanceID>
                      <flowName></flowName>
                      <ordemCompra>
                         <codigoEmpresa>${codEmp}</codigoEmpresa>
                         <codigoFilial>${codFil}</codigoFilial>
                         <numero>${numOcp}</numero>
                         <sequencia>${seqOcp}</sequencia>
                      </ordemCompra>
                   </parameters>
                </ser:aprovar>
             </soapenv:Body>
          </soapenv:Envelope>
      ''',
    );

    if (response.statusCode == 200) {
      late final resultado;
      final body = response.body;
      final parsedXml = xml.XmlDocument.parse(body);

      final tpResultado =
          parsedXml.findAllElements('codigoResultado').single.text;
      final document = await xml.XmlDocument.parse(response.body);
      final list = await document.findAllElements('retorno').map((node) async {
        resultado = await node
            .findElements('mensagemErro')
            .toString()
            .replaceAll('</mensagemErro>)', '')
            .replaceAll('(<mensagemErro>', '');
      }).toList();
      return tpResultado.contains('1') ? '1: execução sem erros' : resultado;
    } else {
      return 'Desculpe! Houve um erro de conexão';
    }
  } else if (ind == 2) {
    // Cancelar
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'text/xml; charset=UTF-8'},
      body: '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
          <soapenv:Body>
            <ser:reprovar>
              <user>${usu.username}</user>
              <password>${usu.password}</password>
              <encryption>0</encryption>
              <parameters>
                <ordemCompra>
                  <sequência>${seqOcp}</sequência>
                  <codigoEmpresa>${codEmp}</codigoEmpresa>
                  <codigoFilial>${codFil}</codigoFilial>
                  <numero>${numOcp}</numero>
                </ordemCompra>
              </parameters>
            </ser:reprovar>
          </soapenv:Body>
        </soapenv:Envelope>
      ''',
    );

    if (response.statusCode == 200) {
      late final resultado;
      final body = response.body;
      final parsedXml = xml.XmlDocument.parse(body);

      final tpResultado =
          parsedXml.findAllElements('codigoResultado').single.text;
      final document = await xml.XmlDocument.parse(response.body);
      final list = await document.findAllElements('retorno').map((node) async {
        resultado = await node
            .findElements('mensagemErro')
            .toString()
            .replaceAll('</mensagemErro>)', '')
            .replaceAll('(<mensagemErro>', '');
      }).toList();
      return tpResultado.contains('1') ? '1: execução sem erros' : resultado;
    } else {
      return 'Desculpe! Houve um erro de conexão';
    }
  }
  return '';
}

Future<String> SolicitacaoCompra(
    int ind, String seqDoc, String codEmp, String numSol, String seqSol) async {
  String url =
      '${param.GetServer}/g5-senior-services/sapiens_Synccom_senior_g5_co_mcm_est_solicitacaocompra?wsdl';

  if (ind == 1) {
    // Aprovar
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'text/xml; charset=UTF-8'},
      body: '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
           <soapenv:Header/>
           <soapenv:Body>
              <ser:aprovar>
                 <user>${usu.username}</user>
                 <password>${usu.password}</password>
                 <encryption>0</encryption>
                 <parameters>
                    <solicitacao>
                       <codigoEmpresa>$codEmp</codigoEmpresa>
                       <numeroSolicitacao>$numSol</numeroSolicitacao>
                       <sequencia>$seqDoc</sequencia>
                       <sequenciaSolicitacao>$seqSol</sequenciaSolicitacao>
                    </solicitacao>
                 </parameters>
              </ser:aprovar>
           </soapenv:Body>
        </soapenv:Envelope>          
      ''',
    );

    if (response.statusCode == 200) {
      late final resultado;
      final body = response.body;
      final parsedXml = xml.XmlDocument.parse(body);

      final tpResultado =
          parsedXml.findAllElements('codigoResultado').single.text;
      final document = await xml.XmlDocument.parse(response.body);
      final list = await document.findAllElements('retorno').map((node) async {
        resultado = await node
            .findElements('mensagemErro')
            .toString()
            .replaceAll('</mensagemErro>)', '')
            .replaceAll('(<mensagemErro>', '');
      }).toList();
      return tpResultado.contains('1') ? '1: execução sem erros' : resultado;
    } else {
      return 'Desculpe! Houve um erro de conexão';
    }
  } else if (ind == 2) {
    // Cancelar
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'text/xml; charset=UTF-8'},
      body: '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.senior.com.br">
           <soapenv:Header/>
           <soapenv:Body>
              <ser:reprovar>
                 <user>${usu.username}</user>
                 <password>${usu.password}</password>
                 <encryption>0</encryption>
                 <parameters>
                    <solicitacao>
                       <codigoEmpresa>${codEmp}</codigoEmpresa>                      
                       <numeroSolicitacao>${numSol}</numeroSolicitacao>
                       <sequencia>${seqDoc}</sequencia>
                       <sequenciaSolicitacao>${seqSol}</sequenciaSolicitacao>
                    </solicitacao>
                 </parameters>
              </ser:reprovar>
           </soapenv:Body>
        </soapenv:Envelope>        
      ''',
    );

    if (response.statusCode == 200) {
      late final resultado;
      final body = response.body;
      final parsedXml = xml.XmlDocument.parse(body);

      final tpResultado =
          parsedXml.findAllElements('codigoResultado').single.text;
      final document = await xml.XmlDocument.parse(response.body);
      final list = await document.findAllElements('retorno').map((node) async {
        resultado = await node
            .findElements('mensagemErro')
            .toString()
            .replaceAll('</mensagemErro>)', '')
            .replaceAll('(<mensagemErro>', '');
      }).toList();
      return tpResultado.contains('1') ? '1: execução sem erros' : resultado;
    } else {
      return 'Desculpe! Houve um erro de conexão';
    }
  }
  return '';
}
