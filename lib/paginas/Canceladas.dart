import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_Campos.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Aprovar_Cancelar.dart';
import 'package:ControleAprovacao/requisicoes/Rest_Consulta.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../model/Model_ModulosContratados.dart';
import '../model/Model_Usuario.dart';
import 'Controles.dart';

class Canceladas extends StatefulWidget {
  const Canceladas({Key? key}) : super(key: key);

  @override
  State<Canceladas> createState() => _CanceladasState();
}

class _CanceladasState extends State<Canceladas> {
  late Future<List<Model_Campos>> pendentes;
  Set<String> itensSelecionados = {};
  final _espacoLinhas = 10.0;
  String _rotNap = Model_ModulosContratados().rotNapSelect;
  late TextEditingController _qtdListController;
  late TextEditingController _qtdShowController;
  CurrencyTextInputFormatter mask = CurrencyTextInputFormatter.currency(
      symbol: '', name: 'BRL', locale: 'pt-BR');

  @override
  void initState() {
    super.initState();
    pendentes = fetchConsulta('CAN', _rotNap);
  }

  @override
  Widget build(BuildContext context) {
    String apr = '';
    double sizeFont = 8;
    double sizePop = 12;
    double sizeItem = 12;
    double espaco = 6;

    return Scaffold(
      floatingActionButton: itensSelecionados.isEmpty
          ? null
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Text(
                              'Tem certeza que deseja aprovar os itens selecionados?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Não')),
                            TextButton(
                                onPressed: () async {
                                  String log = '1: execução sem erros';
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            content: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator()
                                                ]),
                                          ));
                                  for (Model_Campos pendentes
                                      in await fetchConsulta('CAN', _rotNap)) {
                                    switch (pendentes.rotDes) {
                                      case 'COTAÇÃO':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          String apr = await Cotacao(
                                              1,
                                              pendentes.codEmp,
                                              pendentes.numDoc,
                                              pendentes.seqDoc,
                                              Model_Usuario().codUsu);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                      case 'REQUISIÇÃO':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          String apr = await Requisicao(
                                              1,
                                              pendentes.codEmp,
                                              pendentes.numDoc,
                                              pendentes.seqDoc,
                                              Model_Usuario().codUsu,
                                              pendentes.qtdEme);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                      case 'SOLICITAÇÃO DE COMPRA':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          apr = await SolicitacaoCompra(
                                              1,
                                              '',
                                              pendentes.codEmp,
                                              pendentes.numDoc,
                                              pendentes.seqDoc);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                      case 'ORDEM DE COMPRA':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          apr = await OrdemCompra(
                                              1,
                                              '',
                                              pendentes.codEmp,
                                              pendentes.filDoc,
                                              pendentes.numDoc);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                    }
                                  }
                                  log.contains('1: execução sem erros')
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Concluído!'),
                                              content: Text(
                                                  'Todos os itens foram processados com sucesso!'),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  Controles())));
                                                    },
                                                    child: Text('OK'))
                                              ],
                                            );
                                          })
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('OPS!'),
                                              content: Text(log),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('OK'))
                                              ],
                                            );
                                          });
                                  ;
                                },
                                child: Text('Sim')),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /*FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Text(
                              'Tem certeza que deseja cancelar a aprovação dos itens selecionados?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Não')),
                            TextButton(
                                onPressed: () async {
                                  String log = '1: execução sem erros';
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            content: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator()
                                                ]),
                                          ));
                                  for (Model_Campos pendentes
                                      in await fetchConsulta('CAN', _rotNap)) {
                                    switch (pendentes.rotDes) {
                                      case 'COTAÇÃO':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          apr = await Cotacao(
                                              2,
                                              pendentes.codEmp,
                                              pendentes.numDoc,
                                              pendentes.seqDoc,
                                              Model_Usuario().codUsu);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                      case 'REQUISIÇÃO':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          apr = await Requisicao(
                                              2,
                                              pendentes.codEmp,
                                              pendentes.numDoc,
                                              pendentes.seqDoc,
                                              Model_Usuario().codUsu,
                                              pendentes.qtdEme);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                      case 'SOLICITAÇÃO DE COMPRA':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          apr = await SolicitacaoCompra(
                                              2,
                                              '',
                                              pendentes.codEmp,
                                              pendentes.numDoc,
                                              pendentes.seqDoc);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                      case 'ORDEM DE COMPRA':
                                        if (itensSelecionados.contains(
                                            '${pendentes.codEmp}#${pendentes.numDoc}#${pendentes.seqDoc}')) {
                                          apr = await OrdemCompra(
                                              2,
                                              '',
                                              pendentes.codEmp,
                                              pendentes.filDoc,
                                              pendentes.numDoc);
                                          apr.contains('1: execução sem erros')
                                              ? null
                                              : log = apr;
                                        }
                                        break;
                                    }
                                  }
                                  log.contains('1: execução sem erros')
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Concluído!'),
                                              content: Text(
                                                  'Todos os itens foram processados com sucesso!'),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  Controles())));
                                                    },
                                                    child: Text('OK'))
                                              ],
                                            );
                                          })
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('OPS!'),
                                              content: Text(log),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('OK'))
                                              ],
                                            );
                                          });
                                  // Navigator.pop(context);
                                  // Navigator.of(context).pop();
                                },
                                child: Text('Sim')),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.red,
                  ),*/
                ],
              ),
            ),
      appBar: itensSelecionados.isEmpty
          ? null
          : AppBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '${itensSelecionados.length} selecionado(s)',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          itensSelecionados.clear();
                        });
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.black87,
                      )),
                ),
              ],
              backgroundColor: Colors.indigo[50],
              elevation: 0.1,
            ),
      body: Center(
        child: Container(
          //width: 320,
          padding: EdgeInsets.all(2),
          child: FutureBuilder<List<Model_Campos>>(
            future: pendentes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao carregar os itens'),
                );
              } else if (snapshot.hasData) {
                final items = snapshot.data!;
                return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        selectedTileColor: Colors.blueGrey[50],
                        selected: itensSelecionados.contains(
                            '${item.codEmp}#${item.numDoc}#${item.seqDoc}'),
                        leading: (itensSelecionados.contains(
                                '${item.codEmp}#${item.numDoc}#${item.seqDoc}'))
                            ? CircleAvatar(
                                child: Icon(Icons.check),
                              )
                            : null,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Center(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                    child: (item.rotDes
                                                            .contains(
                                                                'REQUISIÇÃO'))
                                                        ? Icon(Icons
                                                            .note_alt_outlined)
                                                        : (item.rotDes.contains(
                                                                'SOLICITAÇÃO DE COMPRA'))
                                                            ? Icon(Icons
                                                                .production_quantity_limits_outlined)
                                                            : (item.rotDes
                                                                    .contains(
                                                                        'COTAÇÃO'))
                                                                ? Icon(Icons
                                                                    .shopping_cart_checkout_outlined)
                                                                : (item.rotDes
                                                                        .contains(
                                                                            'ORDEM DE COMPRA'))
                                                                    ? Icon(Icons
                                                                        .add_shopping_cart_outlined)
                                                                    : null),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Icon(
                                                      Icons.close_outlined,
                                                      color: Colors.grey,
                                                    ))
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 4,
                                                  bottom: 4,
                                                  left: 16,
                                                  right: 16),
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    0, 74, 173, 100),
                                                border: Border.all(
                                                    width: 0,
                                                    color: Color.fromRGBO(
                                                        0, 74, 173, 100)),
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              child: Text(
                                                item.rotDes,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: sizeFont,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    Text(
                                                      item.rotDes.contains(
                                                              'REQUISIÇÃO')
                                                          ? (item.codSer)
                                                                  .isEmpty
                                                              ? '${item.codPro} - ${item.nomPro}'
                                                              : '${item.codSer} - ${item.nomSer}'
                                                          : item.nomEnt
                                                              .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )),
                                            Container(
                                              color: Colors.black26,
                                              height: 1,
                                              width: 350,
                                            )
                                          ]),
                                    ),
                                    content: SingleChildScrollView(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        item.rotDes.contains('REQUISIÇÃO')
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Solicitante',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: sizePop),
                                                  ),
                                                  Text(
                                                    item.usuSol.toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: sizeItem,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: _espacoLinhas,
                                                  ),
                                                  Text(
                                                    'Solicitado em',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: sizePop),
                                                  ),
                                                  Text(
                                                    item.datDoc,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: sizeItem,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: _espacoLinhas * 2,
                                                  ),
                                                ],
                                              )
                                            : item.rotDes.contains(
                                                    'SOLICITAÇÃO DE COMPRA')
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Solicitante',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: sizePop),
                                                      ),
                                                      Text(
                                                        item.usuSol
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: sizeItem,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: _espacoLinhas,
                                                      ),
                                                      Text(
                                                        'Solicitado em',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: sizePop),
                                                      ),
                                                      Text(
                                                        item.datDoc,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: sizeItem,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            _espacoLinhas * 2,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 0,
                                                  ),
                                        Text(
                                          'Número',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: sizePop),
                                        ),
                                        Text(
                                          item.numDoc,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: sizeItem,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: _espacoLinhas,
                                        ),
                                        item.rotDes.contains('REQUISIÇÃO')
                                            ? SizedBox(height: 0)
                                            : item.rotDes.contains(
                                                    'SOLICITAÇÃO DE COMPRA')
                                                ? SizedBox(height: 0)
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.rotDes.contains(
                                                                'COTAÇÃO')
                                                            ? 'Data Cotação'
                                                            : item.rotDes.contains(
                                                                    'ORDEM DE COMPRA')
                                                                ? 'Data Emissão'
                                                                : '',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: sizePop),
                                                      ),
                                                      Text(
                                                        item.datDoc,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: sizeItem,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                        SizedBox(
                                          height: item.rotDes
                                                  .contains('REQUISIÇÃO')
                                              ? 0
                                              : item.rotDes.contains(
                                                      'SOLICITAÇÃO DE COMPRA')
                                                  ? 0
                                                  : _espacoLinhas,
                                        ),
                                        item.rotDes.contains('ORDEM DE COMPRA')
                                            ? SizedBox(
                                                height: 0,
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Produto/Serviço',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: sizePop),
                                                  ),
                                                  Container(
                                                    child: (item.codSer.isEmpty
                                                        ? Text(
                                                            '${item.nomPro} - ${item.codPro}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    sizeItem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            '${item.nomSer} - ${item.codSer}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    sizeItem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                  )
                                                ],
                                              ),
                                        SizedBox(
                                          height: _espacoLinhas,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Quantidade',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: sizePop),
                                            ),
                                            Text(
                                              item.qtdDoc,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: sizeItem,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: _espacoLinhas,
                                        ),
                                        item.rotDes.contains('REQUISIÇÃO')
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    'Quantidade Aprovação',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: sizePop),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                    width: 100,
                                                    child: TextFormField(
                                                      enabled: false,
                                                      onChanged: (value) {
                                                        items[index].qtdEme =
                                                            value;
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.right,
                                                      maxLines: 1,
                                                      controller:
                                                          _qtdShowController =
                                                              TextEditingController(
                                                                  text: item
                                                                      .qtdEme),
                                                      inputFormatters: [mask],
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        hintText: '0,00',
                                                        hintStyle: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : SizedBox(
                                                height: 0,
                                              ),
                                        item.rotDes.contains('REQUISIÇÃO')
                                            ? SizedBox(
                                                height: _espacoLinhas,
                                              )
                                            : SizedBox(
                                                height: 0,
                                              ),
                                        item.rotDes.contains('ORDEM DE COMPRA')
                                            ? Container()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Prazo de Entrega',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: sizePop),
                                                  ),
                                                  Text(
                                                    item.datPrv,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: sizeItem,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 8),
                                            child: Container(
                                              color: Colors.black26,
                                              height: 1,
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.rotDes.contains('REQUISIÇÃO')
                                                  ? 'Valor Aproximado'
                                                  : 'Valor',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: sizePop),
                                            ),
                                            Text(
                                              'R\$ ${item.vlrApr}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: sizeItem,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: _espacoLinhas,
                                        ),
                                        item.rotDes.contains('REQUISIÇÃO')
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Centro de Custo',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: sizePop),
                                                  ),
                                                  Text(
                                                    item.ccuRes,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: sizeItem,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  item.rotDes.contains(
                                                          'REQUISIÇÃO')
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Valor Desconto',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      sizePop),
                                                            ),
                                                            Text(
                                                              'R\$ ${item.vlrDsc}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      sizeItem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        )
                                                      : Container(),
                                                  SizedBox(
                                                    height: item.rotDes
                                                            .contains(
                                                                'REQUISIÇÃO')
                                                        ? _espacoLinhas
                                                        : 0,
                                                  ),
                                                  item.rotDes.contains(
                                                          'REQUISIÇÃO')
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Valor Presente',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      sizePop),
                                                            ),
                                                            Text(
                                                              'R\$ ${item.vlrPrs}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      sizeItem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        )
                                                      : Container(),
                                                  SizedBox(
                                                    height: item.rotDes
                                                            .contains(
                                                                'REQUISIÇÃO')
                                                        ? _espacoLinhas
                                                        : 0,
                                                  ),
                                                  item.rotDes.contains(
                                                          'SOLICITAÇÃO DE COMPRA')
                                                      ? SizedBox(
                                                          height: 0,
                                                        )
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Condição de Pagamento',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      sizePop),
                                                            ),
                                                            Text(
                                                              item.desCpg,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      sizeItem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                ],
                                              )
                                      ],
                                    )),
                                    actions: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(1),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  'Atenção!'),
                                                              content: Text(
                                                                  'Tem certeza que deseja aprovar?'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        'Não')),
                                                                TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Center(
                                                                              child: CircularProgressIndicator(),
                                                                            );
                                                                          });
                                                                      switch (item
                                                                          .rotDes) {
                                                                        case 'COTAÇÃO':
                                                                          apr = await Cotacao(
                                                                              1,
                                                                              item.codEmp,
                                                                              item.numDoc,
                                                                              item.seqDoc,
                                                                              Model_Usuario().codUsu);
                                                                          break;
                                                                        case 'REQUISIÇÃO':
                                                                          apr = await Requisicao(
                                                                              1,
                                                                              item.codEmp,
                                                                              item.numDoc,
                                                                              item.seqDoc,
                                                                              Model_Usuario().codUsu,
                                                                              item.qtdEme);
                                                                          break;
                                                                        case 'SOLICITAÇÃO DE COMPRA':
                                                                          apr = await SolicitacaoCompra(
                                                                              1,
                                                                              '',
                                                                              item.codEmp,
                                                                              item.numDoc,
                                                                              item.seqDoc);
                                                                          break;
                                                                        case 'ORDEM DE COMPRA':
                                                                          apr = await OrdemCompra(
                                                                              1,
                                                                              '',
                                                                              item.codEmp,
                                                                              item.filDoc,
                                                                              item.numDoc);
                                                                          break;
                                                                      }
                                                                      if (apr.contains(
                                                                          '1: execução sem erros')) {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: Text('Concluído!'),
                                                                                content: Text('Processado com sucesso!'),
                                                                                actions: [
                                                                                  ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => Controles()))), child: Text('OK'))
                                                                                ],
                                                                              );
                                                                            });
                                                                        apr =
                                                                            '';
                                                                      } else {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: Text('OPS!'),
                                                                                content: Text(apr),
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text('OK'))
                                                                                ],
                                                                              );
                                                                            });
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                        'Sim')),
                                                              ],
                                                            ));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: const Text(
                                                  'APROVAR',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          0, 74, 173, 100)),
                                            ),
                                          ),
                                          /*Padding(
                                            padding: EdgeInsets.all(1),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    'Atenção!'),
                                                                content: Text(
                                                                    'Tem certeza que deseja cancelar?'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          'Não')),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Center(
                                                                              child: CircularProgressIndicator(),
                                                                            );
                                                                          });
                                                                      late String
                                                                          apr;
                                                                      switch (item
                                                                          .rotDes) {
                                                                        case 'REQUISIÇÃO':
                                                                          apr = await Requisicao(
                                                                              2,
                                                                              item.codEmp,
                                                                              item.numDoc,
                                                                              item.seqDoc,
                                                                              Model_Usuario().codUsu,
                                                                              item.qtdEme);
                                                                          break;
                                                                        case 'COTAÇÃO':
                                                                          apr = await Cotacao(
                                                                              2,
                                                                              item.codEmp,
                                                                              item.numDoc,
                                                                              item.seqDoc,
                                                                              Model_Usuario().codUsu);
                                                                          break;
                                                                        case 'SOLICITAÇÃO DE COMPRA':
                                                                          apr = await SolicitacaoCompra(
                                                                              2,
                                                                              '',
                                                                              item.codEmp,
                                                                              item.numDoc,
                                                                              item.seqDoc);
                                                                          break;
                                                                        case 'ORDEM DE COMPRA':
                                                                          apr = await OrdemCompra(
                                                                              2,
                                                                              '',
                                                                              item.codEmp,
                                                                              item.filDoc,
                                                                              item.numDoc);
                                                                          break;
                                                                      }
                                                                      if (apr.contains(
                                                                          '1: execução sem erros')) {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: Text('Concluído!'),
                                                                                content: Text('Processado com sucesso!'),
                                                                                actions: [
                                                                                  ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => Controles()))), child: Text('OK'))
                                                                                ],
                                                                              );
                                                                            });
                                                                      } else {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: Text('OPS!'),
                                                                                content: Text(apr),
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text('OK'))
                                                                                ],
                                                                              );
                                                                            });
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        'Sim'),
                                                                  ),
                                                                ],
                                                              ));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Text(
                                                    'CANCELAR',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 74, 173, 100),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    side: BorderSide(
                                                        color: Color.fromRGBO(
                                                            0, 74, 173, 100),
                                                        width: 1))),
                                          ),*/
                                        ],
                                      )
                                    ],
                                  ));
                        },
                        onLongPress: () {
                          setState(() {
                            itensSelecionados.contains(
                                    '${item.codEmp}#${item.numDoc}#${item.seqDoc}')
                                ? itensSelecionados.remove(
                                    '${item.codEmp}#${item.numDoc}#${item.seqDoc}')
                                : itensSelecionados.add(
                                    '${item.codEmp}#${item.numDoc}#${item.seqDoc}');
                          });
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /*
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 4, bottom: 4, left: 8, right: 8),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 74, 173, 100),
                                    border: Border.all(
                                        width: 0,
                                        color: Color.fromRGBO(0, 74, 173, 100)),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Text(
                                    item.rotDes,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: sizeFont,
                                        color: Colors.white),
                                  ),
                                ),*/
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.rotDes, // 'DOCUMENTO'
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: sizeFont + 1,
                                        color: Colors.blueGrey)),
                                Text(
                                    item.rotDes.contains('REQUISIÇÃO')
                                        ? 'VALOR APROXIMADO'
                                        : 'VALOR',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: sizeFont,
                                        color: Colors.grey)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.numDoc,
                                    style: TextStyle(
                                        fontSize: sizeItem,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold)),
                                Text('R\$ ${item.vlrApr}',
                                    style: TextStyle(
                                        fontSize: sizeItem,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: espaco),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        item.rotDes.contains('ORDEM DE COMPRA')
                                            ? 'EMISSÃO'
                                            : 'PRODUTO / SERVIÇO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizeFont,
                                            color: Colors.grey)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        item.rotDes.contains('ORDEM DE COMPRA')
                                            ? item.datDoc
                                            : (item.codSer).isEmpty
                                                ? '${item.codPro} - ${item.nomPro}'
                                                : '${item.codSer} - ${item.nomSer}',
                                        style: TextStyle(
                                            fontSize: sizeItem,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                item.rotDes.contains('ORDEM DE COMPRA')
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    : (item.codSer).isEmpty
                                        ? (item.codDer).isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(item.codDer,
                                                      style: TextStyle(
                                                          fontSize: sizeItem,
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight
                                                              .normal))
                                                ],
                                              )
                                            : const SizedBox(height: 0)
                                        : const SizedBox(height: 0)
                              ],
                            ),
                            item.rotDes.contains('REQUISIÇÃO')
                                ? SizedBox(
                                    height: 10,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            item.rotDes.contains('REQUISIÇÃO')
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text('QUANTIDADE',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: sizeFont,
                                                    color: Colors.grey)),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text('QUANTIDADE APR.',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: sizeFont,
                                                    color: Colors.grey)),
                                          ),
                                          Expanded(flex: 3, child: Container()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(item.qtdDoc,
                                                style: TextStyle(
                                                    fontSize: sizeItem,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              height: 20,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  items[index].qtdEme = value;
                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                maxLines: 1,
                                                inputFormatters: [mask],
                                                controller: _qtdListController =
                                                    TextEditingController(
                                                        text: item.qtdEme),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(2),
                                                  hintStyle: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                  border: OutlineInputBorder(),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(flex: 3, child: Container()),
                                        ],
                                      )
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: espaco),
                            item.rotDes.contains('REQUISIÇÃO')
                                ? Row(
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Text('SOLICITANTE',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizeFont,
                                                  color: Colors.grey))),
                                    ],
                                  )
                                : item.rotDes.contains('ORDEM DE COMPRA')
                                    ? Row(
                                        children: [
                                          Expanded(
                                              flex: 8,
                                              child: Text('FORNECEDOR',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: sizeFont,
                                                      color: Colors.grey))),
                                        ],
                                      )
                                    : item.rotDes
                                            .contains('SOLICITAÇÃO DE COMPRA')
                                        ? Row(
                                            children: [
                                              Expanded(
                                                  flex: 8,
                                                  child: Text('SOLICITANTE',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: sizeFont,
                                                          color: Colors.grey))),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 0,
                                          ),
                            item.rotDes.contains('REQUISIÇÃO')
                                ? Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Text(item.usuSol.toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  )
                                : item.rotDes.contains('SOLICITAÇÃO DE COMPRA')
                                    ? Row(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Text(
                                                item.usuSol.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      )
                                    : Text(item.nomEnt.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0,
                      );
                    });
              } else {
                return Center(
                  child: Text('Nenhum item encontrado'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
