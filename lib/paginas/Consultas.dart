import 'package:ControleAprovacao/components/showItemDetail.dart';
import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_Campos.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Aprovar_Cancelar.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Consulta.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../model/Model_ModulosContratados.dart';
import '../model/Model_Usuario.dart';
import 'Controles.dart';

class Consultas extends StatefulWidget {
  final String rotNap;

  const Consultas({Key? key, required this.rotNap}) : super(key: key);

  @override
  State createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  String apr = '';
  double sizeFont = 8;
  double sizePop = 12;
  double sizeItem = 12;
  double espaco = 6;

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

  @override
  void initState() {
    super.initState();
    pendentes = fetchConsulta(widget.rotNap, _rotNap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: itensSelecionados.isEmpty
          ? null
          : buildFloatingActionButtons(context),
      appBar: buildAppBar(),
      body: Center(child: buildFutureBuilder()),
    );
  }

  Widget buildFloatingActionButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildFloatingActionButton(
          context,
          Icons.check_outlined,
          Colors.green,
          'Tem certeza que deseja aprovar os itens selecionados?',
          (pendente) {
            approveItem(pendente);
          },
        ),
        const SizedBox(height: 15),
        buildFloatingActionButton(
          context,
          Icons.clear,
          Colors.red,
          'Tem certeza que deseja cancelar os itens selecionados?',
          (pendente) {
            cancelItem(pendente);
          },
        ),
      ],
    );
  }

  Widget buildFloatingActionButton(BuildContext context, IconData icon,
      Color color, String message, Function(Model_Campos) action) {
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
                  String log = await processItems(action);
                  Navigator.pop(context);
                  showResultDialog(log);
                },
                child: const Text('Sim')),
          ],
        ),
      ),
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
    );
  }

  Future<String> processItems(Function(Model_Campos) action) async {
    String log = '1: execução sem erros';
    showLoadingDialog();

    for (Model_Campos pendente in await fetchConsulta('ANA', _rotNap)) {
      if (itensSelecionados.contains(
          '${pendente.codEmp}#${pendente.numDoc}#${pendente.seqDoc}')) {
        log = await action(pendente) ?? log;
      }
    }
    return log;
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const AlertDialog(
        content: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void showResultDialog(String log) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              log.contains('1: execução sem erros') ? 'Concluído!' : 'OPS!'),
          content: Text(log),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (log.contains('1: execução sem erros')) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Controles(setRot: 0)));
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> approveItem(Model_Campos pendente) async {
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
        return null;
    }
  }

  Future<String?> cancelItem(Model_Campos pendente) async {
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
        return null;
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
          SizedBox(height: espaco),
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
          const SizedBox(height: 5),
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
            fontSize: sizeFont + 1,
            color: Colors.blueGrey,
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: sizeItem,
                color: Colors.black87,
                fontWeight: FontWeight.normal,
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
        )
      ],
    );
  }

// Função para exibir o nome da entidade
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
}