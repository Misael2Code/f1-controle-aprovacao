import 'package:ControleAprovacao/components/showInformation.dart';
import 'package:ControleAprovacao/components/showItemDetail.dart';
import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_Campos.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Aprovar_Cancelar.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Consulta.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../model/Model_ModulosContratados.dart';
import '../model/Model_Usuario.dart';
import 'Controles.dart';
import 'dart:async';

class Consultas extends StatefulWidget {
  final String rotNap;

  const Consultas({super.key, required this.rotNap});

  @override
  State createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  String apr = '';
  double sizeFont = 8;
  double sizePop = 12;
  double sizeItem = 12;
  double espaco = 6;

  Timer? _timer;
  late Future<List<Model_Campos>> pendentes;
  Set<String> itensSelecionados = {};
  final double _espacoLinhas = 10.0;
  final String _rotNap = Model_ModulosContratados().rotNapSelect;
  // ignore: unused_field
  late TextEditingController _qtdListController;
  // ignore: unused_field
  late TextEditingController _qtdShowController;
  CurrencyTextInputFormatter mask = CurrencyTextInputFormatter.currency(
      symbol: '', name: 'BRL', locale: 'pt-BR');
  List<Map<String, dynamic>> listAgrupado = [];

  @override
  void initState() {
    super.initState();
    pendentes = fetchConsulta(widget.rotNap, _rotNap);
    _timer = Timer.periodic(const Duration(minutes: 2), (Timer timer) {
      setState(() {
        pendentes = fetchConsulta(widget.rotNap, _rotNap);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: itensSelecionados.isEmpty
          ? buildFloatingActionButtonsInformation(context)
          : buildFloatingActionButtons(context),
      appBar: buildAppBar(),
      body: Center(child: buildFutureBuilder()),
    );
  }

  Widget buildFloatingActionButtonsInformation(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              mini: true,
              elevation: 20,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'image/logotipo.png',
                height: 48,
              ),
              onPressed: () {
                showInformation(context, widget.rotNap, '', 580);
              }),
        ],
      ),
    );
  }

  Widget? buildFloatingActionButtons(BuildContext context) {
    switch (widget.rotNap) {
      case 'ANA':
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildFloatingActionButton(
                context,
                Icons.check_outlined,
                Colors.green,
                'Tem certeza que deseja aprovar os itens selecionados?',
                'Aprovar'),
            const SizedBox(height: 15),
            buildFloatingActionButton(
                context,
                Icons.clear,
                Colors.red,
                'Tem certeza que deseja reprovar os itens selecionados?',
                'Reprovar'),
          ],
        );
      case 'APR':
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildFloatingActionButton(
                context,
                Icons.clear,
                Colors.red,
                'Tem certeza que deseja reprovar os itens selecionados?',
                'Reprovar'),
          ],
        );
      case 'CAN':
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildFloatingActionButton(
                context,
                Icons.check_outlined,
                Colors.green,
                'Tem certeza que deseja aprovar os itens selecionados?',
                'Aprovar'),
          ],
        );
      default:
        return null;
    }
  }

  Widget buildFloatingActionButton(BuildContext context, IconData icon,
      Color color, String message, String action) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não')),
            TextButton(
                onPressed: () async {
                  await processItems(action);
                  Navigator.pop(context);
                  _mostrarDialog(context);
                },
                child: const Text('Sim')),
          ],
        ),
      ),
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
    );
  }

  void _mostrarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: GestureDetector(
            onTap: () {
              showInformation(context, 'AGP', '', 400);
            },
            child: Image.asset(
              'image/logotipo.png',
              height: 36,
            ),
          ),
          title: const Text("Itens processados"),
          content: SingleChildScrollView(
            child: listaAgrupados(),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Fechar",
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Controles(setRot: 0)));
              },
            ),
          ],
        );
      },
    );
  }

  Widget listaAgrupados() {
    double fontSize = 12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: listAgrupado.map((registro) {
        String routine = ' ${registro['rotina']}: ';
        String product = registro['produto'];
        String number = registro['numero'];
        String result = registro['resultado'];

        return Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: Color.fromRGBO(1, 73, 172, 100),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    routine,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(
                    'Nº:',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Text(
                    number,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Text(
                    'Código:',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Text(
                    product,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                if (result.contains('Ok')) ...[
                  const Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }

  Future<String> processItems(String actions) async {
    String log = '1: execução sem erros';
    showLoadingDialog();

    for (Model_Campos pendente in await fetchConsulta('ANA', _rotNap)) {
      if (itensSelecionados.contains(
          '${pendente.codEmp}#${pendente.numDoc}#${pendente.seqDoc}')) {
        switch (actions) {
          case 'Aprovar':
            log = await approveItem(pendente);
            break;
          case 'Reprovar':
            log = await cancelItem(pendente);
            break;
        }
        if (log.contains('1: execução sem erros')) {
          switch (pendente.rotDes) {
            case 'ORDEM DE COMPRA':
              listAgrupado.add({
                'rotina': pendente.rotDes,
                'produto': ' ',
                'numero': pendente.numDoc,
                'resultado': 'Ok'
              });
              break;
            default:
              listAgrupado.add({
                'rotina': pendente.rotDes,
                'produto': pendente.codPro.isNotEmpty
                    ? pendente.codPro
                    : pendente.codSer,
                'numero': pendente.numDoc,
                'resultado': 'Ok'
              });
          }
        } else {
          switch (pendente.rotDes) {
            case 'ORDEM DE COMPRA':
              listAgrupado.add({
                'rotina': pendente.rotDes,
                'produto': '',
                'numero': pendente.numDoc,
                'resultado': 'Falha'
              });
              break;
            default:
              listAgrupado.add({
                'rotina': pendente.rotDes,
                'produto': pendente.codPro.isNotEmpty
                    ? pendente.codPro
                    : pendente.codSer,
                'numero': pendente.numDoc,
                'resultado': 'Falha'
              });
          }
        }
      }
    }
    return log;
  }

  void showLoadingDialog() {
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

  void showResultDialog(BuildContext context, String log) {
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

  Future<String> approveItem(Model_Campos pendente) async {
    switch (pendente.rotDes) {
      case 'COTAÇÃO':
        return await Cotacao(1, pendente.codEmp, pendente.numDoc,
            pendente.seqDoc, Model_Usuario().codUsu);
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
        return await Cotacao(2, pendente.codEmp, pendente.numDoc,
            pendente.seqDoc, Model_Usuario().codUsu);
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

  AppBar? buildAppBar() {
    return itensSelecionados.isEmpty
        ? null
        : AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${itensSelecionados.length} selecionado(s)',
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () => setState(() {
                    itensSelecionados.clear();
                  }),
                  icon:
                      const Icon(Icons.cancel_outlined, color: Colors.black87),
                ),
              ),
            ],
            backgroundColor: Colors.indigo[50],
            elevation: 0.1,
          );
  }

  Widget buildFutureBuilder() {
    return FutureBuilder<List<Model_Campos>>(
      future: pendentes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar os itens'));
        } else if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) => buildListTile(items[index], index),
            separatorBuilder: (_, __) => const Divider(),
          );
        } else {
          return const Center(child: Text('Nenhum item encontrado'));
        }
      },
    );
  }

  Widget buildListTile(Model_Campos item, int index) {
    bool isSelected = itensSelecionados
        .contains('${item.codEmp}#${item.numDoc}#${item.seqDoc}');

    return ListTile(
      onTap: () => showItemDetails(context, item, apr, sizeFont, sizePop,
          sizeItem, espaco, _espacoLinhas, widget.rotNap),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      selectedTileColor: Colors.blueGrey[50],
      selected: isSelected,
      leading: isSelected ? const CircleAvatar(child: Icon(Icons.check)) : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: SizedBox.shrink(),
          ),
          _buildHeaderRow(item.rotDes, sizeFont),
          _buildInfoRow(item.numDoc, 'R\$ ${item.vlrApr}', sizeItem),
          _buildConditionalRow(
            condition: item.rotDes.contains('ORDEM DE COMPRA'),
            firstLabel: 'EMISSÃO',
            secondLabel: 'PRODUTO / SERVIÇO',
            value: item.rotDes.contains('ORDEM DE COMPRA')
                ? item.datDoc
                : item.codSer.isEmpty
                    ? '${item.codPro} - ${item.nomPro}'
                    : '${item.codSer} - ${item.nomSer}',
            sizeFont: sizeFont,
            sizeItem: sizeItem,
          ),
          _buildAdditionalInfo(item),
          if (item.rotDes.contains('REQUISIÇÃO')) ...[
            const SizedBox(height: 10),
            _buildQuantitySection(item, sizeFont, sizeItem),
            SizedBox(height: espaco),
            _buildRequestInfo(
                item.rotDes, sizeFont, 'SOLICITANTE', item.usuSol),
          ],
          if (item.rotDes.contains('ORDEM DE COMPRA')) ...[
            _buildRequestInfo(item.rotDes, sizeFont, 'FORNECEDOR', item.nomEnt),
          ] else if (item.rotDes.contains('SOLICITAÇÃO DE COMPRA')) ...[
            _buildRequestInfo(
                item.rotDes, sizeFont, 'SOLICITANTE', item.usuSol),
          ] else if (item.rotDes.contains('COTAÇÃO')) ...[
            _buildRequestInfo(item.rotDes, sizeFont, 'FORNECEDOR', item.nomEnt),
          ] else ...[
            const SizedBox(height: 0),
          ],
          //const SizedBox(height: 5),
        ],
      ),
      onLongPress: () {
        setState(() {
          itensSelecionados
                  .contains('${item.codEmp}#${item.numDoc}#${item.seqDoc}')
              ? itensSelecionados
                  .remove('${item.codEmp}#${item.numDoc}#${item.seqDoc}')
              : itensSelecionados
                  .add('${item.codEmp}#${item.numDoc}#${item.seqDoc}');
        });
      },
    );
  }

  // Função para construir o cabeçalho
  Widget _buildHeaderRow(String rotDes, double sizeFont) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rotDes,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: sizeFont + 3,
            color: const Color.fromRGBO(1, 14, 33, 1),
          ),
        ),
        Text(
          rotDes.contains('REQUISIÇÃO') ? 'VALOR APROXIMADO' : 'VALOR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: sizeFont,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

// Função para construir uma linha com informações
  Widget _buildInfoRow(String leftText, String rightText, double sizeItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: TextStyle(
            fontSize: sizeItem,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          rightText,
          style: TextStyle(
            fontSize: sizeItem,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

// Função para construir uma linha condicional
  Widget _buildConditionalRow({
    required bool condition,
    required String firstLabel,
    required String secondLabel,
    required String value,
    required double sizeFont,
    required double sizeItem,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              condition ? firstLabel : secondLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizeFont,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: sizeItem,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

// Função para exibir derivação do produto
  Widget _buildAdditionalInfo(item) {
    return item.rotDes.contains('ORDEM DE COMPRA')
        ? const SizedBox(height: 0)
        : item.codSer.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.codDer,
                    style: TextStyle(
                      fontSize: sizeItem,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )
            : const SizedBox(height: 0);
  }

// Função para construir a seção de quantidade
  Widget _buildQuantitySection(item, double sizeFont, double sizeItem) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'QUANTIDADE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeFont,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'QUANTIDADE APR.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeFont,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                item.qtdDoc,
                style: TextStyle(
                  fontSize: sizeItem,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 20,
                child: TextFormField(
                  onChanged: (value) {
                    item.qtdEme = value;
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  maxLines: 1,
                  inputFormatters: [mask],
                  controller: _qtdListController =
                      TextEditingController(text: item.qtdEme),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(2),
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ],
    );
  }

// Função para exibir informações do solicitante/fornecedor
  Widget _buildRequestInfo(
      String rotDes, double sizeFont, String label, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeFont,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Text(
          name.toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontSize: sizeItem,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

// Função para exibir o nome da entidade
  /*
  Widget _buildEntityName(String name) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Text(
            name.toUpperCase(),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
  */
}
