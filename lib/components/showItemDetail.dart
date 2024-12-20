import 'package:controle_aprovacao/components/showInformation.dart';
import 'package:controle_aprovacao/model/Model_Campos.dart';
import 'package:controle_aprovacao/model/Model_Usuario.dart';
import 'package:controle_aprovacao/paginas/Controles.dart';
import 'package:controle_aprovacao/requisicoes/Rest_Aprovar_Cancelar.dart';
import 'package:flutter/material.dart';

late String apr;
late double sizeFont;
late double sizePop;
late double sizeItem;
late double espaco;
late double espacoLinhas;

void showItemDetails(
    BuildContext context,
    Model_Campos item,
    String apr,
    double fontSize,
    double popSize,
    double itemSize,
    double espacoSize,
    double espacoLinhasSize,
    String rotNap) {
  sizeFont = fontSize;
  sizePop = popSize;
  sizeItem = itemSize;
  espaco = espacoSize;
  espacoLinhas = espacoLinhasSize;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: _buildDialogTitle(item, context, rotNap),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildDialogContent(item),
          ),
        ),
        actions: _buildDialogActions(context, item, rotNap),
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

Widget _buildDialogTitle(
    Model_Campos item, BuildContext context, String rotNap) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                double sizeHeight = 0;
                switch (item.rotDes) {
                  case 'REQUISIÇÃO':
                    sizeHeight = 400;
                    break;
                  case 'SOLICITAÇÃO DE COMPRA':
                    sizeHeight = 500;
                    break;
                  case 'COTAÇÃO':
                    sizeHeight = 350;
                    break;
                  case 'ORDEM DE COMPRA':
                    sizeHeight = 350;
                    break;
                }
                showInformation(context, rotNap, item.rotDes, sizeHeight);
              },
              child: Image.asset(
                'image/logotipo.png',
                height: 24,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close_outlined, color: Colors.grey),
            ),
          ],
        ),
        //CircleAvatar(child: _getIconForRotDes(item.rotDes)),
        _buildTitleContainer(item.rotDes),
        const SizedBox(height: 12),
        _buildSubtitle(item),
      ],
    ),
  );
}

Widget? _getIconForRotDes(String rotDes) {
  switch (rotDes) {
    case 'REQUISIÇÃO':
      return const Icon(Icons.note_alt_outlined);
    case 'SOLICITAÇÃO DE COMPRA':
      return const Icon(Icons.production_quantity_limits_outlined);
    case 'COTAÇÃO':
      return const Icon(Icons.shopping_cart_checkout_outlined);
    case 'ORDEM DE COMPRA':
      return const Icon(Icons.add_shopping_cart_outlined); // ou um ícone padrão
    default:
      return null;
  }
}

Widget _buildTitleContainer(String rotDes) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(0, 74, 173, 100),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Text(rotDes,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: sizeFont,
            color: Colors.white)),
  );
}

Widget _buildSubtitle(Model_Campos item) {
  String getCode(item) {
    switch (item.rotDes) {
      case 'REQUISIÇÃO':
        return item.codSer.isEmpty ? item.codPro : item.codSer;
      case 'SOLICITAÇÃO DE COMPRA':
        return item.codSer.isEmpty ? item.codPro : item.codSer;
      default:
        return '';
    }
  }

  String getDescription(item) {
    switch (item.rotDes) {
      case 'REQUISIÇÃO':
        return item.codSer.isEmpty ? item.nomPro : item.nomSer;
      case 'SOLICITAÇÃO DE COMPRA':
        return item.codSer.isEmpty ? item.nomPro : item.nomSer;
      default:
        return item.nomEnt.toUpperCase();
    }
  }

  return Wrap(
      //direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(getCode(item),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(getDescription(item),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ]);
}

List<Widget> _buildDialogContent(Model_Campos item) {
  String proSer = item.nomPro.isNotEmpty ? item.nomPro : item.nomSer;
  List<Widget> content = [];

  // Add common fields
  content.addAll([
    _buildSeparator(),
    if (item.rotDes.contains('REQUISIÇÃO')) ...[
      _buildField('Solicitante', item.usuSol.toUpperCase()),
      _buildField('Solicitado em', item.datDoc),
      SizedBox(height: espacoLinhas),
    ],
    if (item.rotDes.contains('SOLICITAÇÃO DE COMPRA')) ...[
      _buildField('Solicitante', item.usuSol.toUpperCase()),
      _buildField('Solicitado em', item.datDoc),
      SizedBox(height: espacoLinhas),
    ],
  ]);

  switch (item.rotDes) {
    case 'REQUISIÇÃO':
      content.addAll(_buildRequisicaoFields(item, proSer));
      break;
    case 'SOLICITAÇÃO DE COMPRA':
      content.addAll(_buildSolicitacaoCompraFields(item, proSer));
      break;
    case 'COTAÇÃO':
      content.addAll(_buildCotacaoFields(item, proSer));
      break;
    case 'ORDEM DE COMPRA':
      content.addAll(_buildOrdemCompraFields(item));
      break;
    default:
      break;
  }

  return content;
}

List<Widget> _buildRequisicaoFields(Model_Campos item, String proSer) {
  return [
    // Add specific fields for Requisição
    _buildField('Número', item.numDoc),
    _buildField('Produto/Serviço', proSer),
    _buildField('Quantidade', item.qtdDoc),
    _buildQuantity('Quantidade a Aprovar', item.qtdEme),
    // Quantidade da Aprovação
    _buildField('Prazo de Entrega', item.datPrv),
    _buildSeparator(),
    _buildField('Valor Aproximado', item.vlrApr),
    _buildField('Centro de Custo', item.ccuRes),
    // Add more fields...
  ];
}

List<Widget> _buildSolicitacaoCompraFields(Model_Campos item, String proSer) {
  return [
    // Add specific fields for Solicitação de Compra
    _buildField('Número', item.numDoc),
    _buildField('Produto/Serviço', proSer),
    _buildField('Quantidade', item.qtdDoc),
    _buildField('Prazo de Entrega', item.datPrv),
    _buildSeparator(),
    _buildField('Valor', item.vlrApr),
    // Add more fields...
  ];
}

List<Widget> _buildCotacaoFields(Model_Campos item, String proSer) {
  return [
    // Add specific fields for Solicitação de Compra
    _buildField('Número', item.numDoc),
    _buildField('Data da Cotação', item.datDoc),
    _buildField('Produto/Serviço', proSer),
    _buildField('Quantidade', item.qtdDoc),
    _buildField('Prazo de Entrega', item.datPrv),
    _buildSeparator(),
    _buildField('Valor', item.vlrApr),
    _buildField('Condição de Pagamento', item.desCpg),
    // Add more fields...
  ];
}

List<Widget> _buildOrdemCompraFields(Model_Campos item) {
  return [
    // Add specific fields for Solicitação de Compra
    _buildField('Número', item.numDoc),
    _buildField('Data da Cotação', item.datDoc),
    _buildField('Quantidade', item.qtdDoc),
    _buildSeparator(),
    _buildField('Valor', item.vlrApr),
    _buildField('Condição de Pagamento', item.desCpg),
    // Add more fields...
  ];
}

Widget _buildField(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: Colors.grey, fontSize: sizePop)),
      Text(value,
          style: TextStyle(
              color: Colors.black,
              fontSize: sizeItem,
              fontWeight: FontWeight.bold)),
      SizedBox(height: espacoLinhas),
    ],
  );
}

Widget _buildQuantity(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label.toUpperCase(),
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: sizePop,
              fontWeight: FontWeight.bold)),
      Text(value,
          style: TextStyle(
              color: Colors.black,
              fontSize: sizeItem,
              fontWeight: FontWeight.bold)),
      SizedBox(height: espacoLinhas),
    ],
  );
}

Widget _buildSeparator() {
  return Column(
    children: [
      Container(
        height: 1,
        color: Colors.black26,
      ),
      SizedBox(
        height: espacoLinhas,
      )
    ],
  );
}

List<Widget> _buildDialogActions(
    BuildContext context, Model_Campos item, String rotNap) {
  List<Widget> actions = [];

  switch (rotNap) {
    case 'APR':
      if (item.rotDes.contains('REQUISIÇÃO')) {
        actions.add(_buildDialogButton(context, item, 'REPROVAR', Colors.white,
            const Color.fromRGBO(0, 74, 173, 100)));
      }
      break;
    case 'ANA':
      actions.add(_buildDialogButton(context, item, 'APROVAR',
          const Color.fromRGBO(0, 74, 173, 100), Colors.white));
      actions.add(_buildDialogButton(context, item, 'REPROVAR', Colors.white,
          const Color.fromRGBO(0, 74, 173, 100)));
      break;
  }
  return actions;
}

ElevatedButton _buildDialogButton(BuildContext context, Model_Campos item,
    String actionText, Color backgroundColor, Color textColor) {
  return ElevatedButton(
    onPressed: () => _confirmAction(context, item, actionText),
    style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
    child: Text(
      actionText,
      style: TextStyle(color: textColor),
    ),
  );
}

void _confirmAction(
    BuildContext context, Model_Campos item, String action) async {
  late String log;

  switch (action) {
    case 'APROVAR':
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Tem certeza que deseja aprovar?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não')),
            TextButton(
                onPressed: () async {
                  showLoadingDialogRequest(context);
                  log = await approveItem(item);
                  Navigator.pop(context);
                  showResultAction(context, log);
                },
                child: const Text('Sim')),
          ],
        ),
      );
    case 'REPROVAR':
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Tem certeza que deseja reprovar?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não')),
            TextButton(
                onPressed: () async {
                  showLoadingDialogRequest(context);
                  log = await cancelItem(item);
                  Navigator.pop(context);
                  showResultAction(context, log);
                },
                child: const Text('Sim')),
          ],
        ),
      );
  }
  // Logic to handle approval or cancellation
}

void showLoadingDialogRequest(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(20), // Optional padding
        width: 200, // Set a specific width
        height: 100, // Set a specific height
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}

Future<String> approveItem(Model_Campos pendente) async {
  switch (pendente.rotDes) {
    case 'COTAÇÃO':
      return await Cotacao(1, pendente.codEmp, pendente.numDoc, pendente.seqDoc,
          Model_Usuario().codUsu);
    case 'REQUISIÇÃO':
      return await Requisicao(1, pendente.codEmp, pendente.numDoc,
          pendente.seqDoc, Model_Usuario().codUsu, pendente.qtdEme);
    case 'SOLICITAÇÃO DE COMPRA':
      return await SolicitacaoCompra(
          1, '', pendente.codEmp, pendente.numDoc, pendente.seqDoc);
    case 'ORDEM DE COMPRA':
      return await OrdemCompra(
          1, '', pendente.codEmp, pendente.filDoc, pendente.numDoc);
    default:
      return '';
  }
}

Future<String> cancelItem(Model_Campos pendente) async {
  switch (pendente.rotDes) {
    case 'COTAÇÃO':
      return await Cotacao(2, pendente.codEmp, pendente.numDoc, pendente.seqDoc,
          Model_Usuario().codUsu);
    case 'REQUISIÇÃO':
      return await Requisicao(2, pendente.codEmp, pendente.numDoc,
          pendente.seqDoc, Model_Usuario().codUsu, pendente.qtdEme);
    case 'ORDEM DE COMPRA':
      return await OrdemCompra(
          2, '', pendente.codEmp, pendente.filDoc, pendente.numDoc);
    case 'SOLICITAÇÃO DE COMPRA':
      return await SolicitacaoCompra(
          2, '', pendente.codEmp, pendente.numDoc, pendente.seqDoc);
    default:
      return '';
  }
}

showResultAction(BuildContext context, String log) {
  switch (log) {
    case '1: execução sem erros':
      log = "Processo executado com sucesso!";
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(log.contains('Processo executado com sucesso!')
            ? 'Concluído!'
            : 'OPS!'),
        content: Text(log),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (log.contains('Processo executado com sucesso!')) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Controles(setRot: 0)));
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
