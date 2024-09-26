import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_ModulosContratados.dart';
import 'package:ControleAprovacao/model/TabBarController.dart';
import 'package:ControleAprovacao/paginas/Aprovadas.dart';
import 'package:ControleAprovacao/paginas/Canceladas.dart';
import 'package:ControleAprovacao/paginas/Modulos.dart';
import 'package:ControleAprovacao/paginas/Pendentes.dart';

class Controles extends StatefulWidget {
  const Controles({Key? key}) : super(key: key);

  @override
  State<Controles> createState() => _ControlesState();
}

class TitlePage {
  String _titlePage = '';

  String get titlePage => _titlePage;

  set titlePage(String value) {
    _titlePage = value;
  }
}

class _ControlesState extends State<Controles>
    with SingleTickerProviderStateMixin {
  TabBarController tab = TabBarController();
  Model_ModulosContratados mod = Model_ModulosContratados();

  @override
  void initState() {
    super.initState();
    tab.controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: 2,
    );
    tab.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tab.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 4,
          initialIndex: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mod.setRot == 0
                          ? 'Controle de Aprovação'
                          : mod.setRot == 3
                              ? 'Requisição'
                              : mod.setRot == 6
                                  ? 'Solicitação de Compra'
                                  : mod.setRot == 9
                                      ? 'Cotação'
                                      : mod.setRot == 12
                                          ? 'Ordem de Compra'
                                          : mod.setRot == 15
                                              ? 'Contrato de Compra'
                                              : mod.setRot == 18
                                                  ? 'Nota Fiscal de Entrada'
                                                  : mod.setRot == 21
                                                      ? 'Fatura de Compra'
                                                      : mod.setRot == 24
                                                          ? 'Contas a Pagar - Entrada'
                                                          : mod.setRot == 27
                                                              ? 'Contas a Pagar - Baixa'
                                                              : mod.setRot == 28
                                                                  ? 'Contas a Pagar - Pagamento Eletrônico'
                                                                  : mod.setRot ==
                                                                          30
                                                                      ? 'Pedido de Venda'
                                                                      : mod.setRot ==
                                                                              31
                                                                          ? 'Pedido de Venda Avalista'
                                                                          : mod.setRot == 33
                                                                              ? 'Pré-Fatura'
                                                                              : mod.setRot == 36
                                                                                  ? 'Contrato de Venda'
                                                                                  : mod.setRot == 39
                                                                                      ? 'Nota Fiscal de Venda'
                                                                                      : mod.setRot == 42
                                                                                          ? 'Fatura de Venda'
                                                                                          : mod.setRot == 45
                                                                                              ? 'Contas a Receber - Entrada'
                                                                                              : mod.setRot == 48
                                                                                                  ? 'Contas a Receber - Baixa'
                                                                                                  : mod.setRot == 51
                                                                                                      ? 'Tesouraria'
                                                                                                      : mod.setRot == 54
                                                                                                          ? 'Projeto'
                                                                                                          : mod.setRot == 57
                                                                                                              ? 'Orçamento Produto/Serviço'
                                                                                                              : mod.setRot == 60
                                                                                                                  ? 'Análise de Crédito - Central de Crédito'
                                                                                                                  : mod.setRot == 61
                                                                                                                      ? 'Análise de Crédito - Crediário'
                                                                                                                      : mod.setRot == 63
                                                                                                                          ? 'Controle Adiantamento - Solicitação'
                                                                                                                          : mod.setRot == 64
                                                                                                                              ? 'Controle Adiantamento - Prestação Contas'
                                                                                                                              : mod.setRot == 66
                                                                                                                                  ? 'Registro Ocorrência - Entrada'
                                                                                                                                  : mod.setRot == 67
                                                                                                                                      ? 'Registro Ocorrência - Baixa'
                                                                                                                                      : mod.setRot == 68
                                                                                                                                          ? 'Registro Ocorrência - Flexibilização'
                                                                                                                                          : mod.setRot == 69
                                                                                                                                              ? 'Entrega Relatórios'
                                                                                                                                              : '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blueGrey),
                      ),
                    ),
                  ],
                )),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Color.fromRGBO(44, 47, 87, 100),
                        Color.fromRGBO(1, 73, 172, 100)
                      ])),
                ),
                bottom: TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: tab.controller,
                  indicatorColor: Colors.white38,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: (width(context) -
                              (menuWidth(width(context)) +
                                  yourWidth(width(context),
                                          menuWidth(width(context))) *
                                      3)) /
                          8),
                  tabs: [
                    Container(
                      width: menuWidth(width(context)),
                      child: Tab(
                          child: Icon(Icons.grid_view_rounded,
                              color: Colors.white)),
                    ),
                    Container(
                      width:
                          yourWidth(width(context), menuWidth(width(context))),
                      child: Tab(
                          child: Column(
                        children: [
                          Icon(Icons.check_circle_outlined,
                              color: Colors.white),
                          Text(
                            'Aprovadas',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      width:
                          yourWidth(width(context), menuWidth(width(context))),
                      child: Tab(
                          child: Column(
                        children: [
                          Icon(Icons.error_outline_outlined,
                              color: Colors.white),
                          Text(
                            'Pendentes',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      width:
                          yourWidth(width(context), menuWidth(width(context))),
                      child: Tab(
                          child: Column(
                        children: [
                          Icon(Icons.highlight_remove_outlined,
                              color: Colors.white),
                          Text(
                            'Canceladas',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                controller: tab.controller,
                children: [
                  Modulos(),
                  Aprovadas(),
                  Pendentes(),
                  Canceladas(),
                ],
              ))),
    );
  }

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double menuWidth(double Width) {
    return Width / 24;
  }

  double yourWidth(double Width, double menuWidth) {
    return (Width - menuWidth) / 4;
  }
}
