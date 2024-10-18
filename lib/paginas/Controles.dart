import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/TabBarController.dart';
import 'package:ControleAprovacao/paginas/Modulos.dart';
import 'package:ControleAprovacao/paginas/Consultas.dart';

class Controles extends StatefulWidget {
  final int setRot; // O valor que será passado

  const Controles({super.key, required this.setRot});

  @override
  State<Controles> createState() => _ControlesState();
}

class _ControlesState extends State<Controles>
    with SingleTickerProviderStateMixin {
  late TabBarController tabController; // Inicializando com 'late'

  @override
  void initState() {
    super.initState();

    // Inicializando o TabBarController
    tabController = TabBarController();
    tabController.controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: 2,
    );
    tabController.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.controller.dispose();
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
                      getModuleTitle(
                          widget.setRot), // Usando o setRot do widget
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blueGrey),
                      ),
                    ),
                  ],
                )),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Color.fromRGBO(44, 47, 87, 100),
                        Color.fromRGBO(1, 73, 172, 100)
                      ])),
                ),
                bottom: TabBar(
                  controller: tabController.controller,
                  indicatorColor: Colors.white38,
                  isScrollable: false,
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: (width(context) -
                              (menuWidth(width(context)) +
                                  yourWidth(width(context),
                                          menuWidth(width(context))) *
                                      4)) /
                          8),
                  tabs: [
                    buildTab(Icons.grid_view_rounded, 'Rotinas', context),
                    buildTab(Icons.check_circle_outlined, 'Aprovadas', context),
                    buildTab(
                        Icons.error_outline_outlined, 'Pendentes', context),
                    buildTab(
                        Icons.highlight_remove_outlined, 'Reprovadas', context),
                  ],
                ),
              ),
              body: TabBarView(
                controller: tabController.controller,
                children: const [
                  Modulos(),
                  Consultas(rotNap: 'APR'), // Aprovadas
                  Consultas(rotNap: 'ANA'), // Pendentes
                  Consultas(rotNap: 'CAN'), // Canceladas
                ],
              ))),
    );
  }

  Widget buildTab(IconData icon, String text, BuildContext context) {
    return SizedBox(
      width: menu(text, context),
      child: Tab(
        child: iconsAba(text, icon),
      ),
    );
  }

  Column iconsAba(String text, IconData icon) {
    switch (text) {
      case 'Rotinas':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
          ],
        );
      default:
        return Column(
          children: [
            Icon(icon, color: Colors.white),
            Text(text,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          ],
        );
    }
  }

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double menuWidth(double width) {
    return width / 8;
  }

  double yourWidth(double width, double menuWidth) {
    return (width - menuWidth) / 4;
  }

  double menu(String m, BuildContext c) {
    switch (m) {
      case 'Rotinas':
        return menuWidth(width(c));
      default:
        return yourWidth(width(c), menuWidth(width(c)));
    }
  }

  String getModuleTitle(int setRot) {
    switch (setRot) {
      case 0:
        return 'Controle de Aprovação';
      case 3:
        return 'Requisição';
      case 6:
        return 'Solicitação de Compra';
      case 9:
        return 'Cotação';
      case 12:
        return 'Ordem de Compra';
      case 15:
        return 'Contrato de Compra';
      case 18:
        return 'Nota Fiscal de Entrada';
      case 21:
        return 'Fatura de Compra';
      case 24:
        return 'Contas a Pagar - Entrada';
      case 27:
        return 'Contas a Pagar - Baixa';
      case 28:
        return 'Contas a Pagar - Pagamento Eletrônico';
      case 30:
        return 'Pedido de Venda';
      case 31:
        return 'Pedido de Venda Avalista';
      case 33:
        return 'Pré-Fatura';
      case 36:
        return 'Contrato de Venda';
      case 39:
        return 'Nota Fiscal de Venda';
      case 42:
        return 'Fatura de Venda';
      case 45:
        return 'Contas a Receber - Entrada';
      case 48:
        return 'Contas a Receber - Baixa';
      case 51:
        return 'Tesouraria';
      case 54:
        return 'Projeto';
      case 57:
        return 'Orçamento Produto/Serviço';
      case 60:
        return 'Análise de Crédito - Central de Crédito';
      case 61:
        return 'Análise de Crédito - Crediário';
      case 63:
        return 'Controle Adiantamento - Solicitação';
      case 64:
        return 'Controle Adiantamento - Prestação Contas';
      case 66:
        return 'Registro Ocorrência - Entrada';
      case 67:
        return 'Registro Ocorrência - Baixa';
      case 68:
        return 'Registro Ocorrência - Flexibilização';
      case 69:
        return 'Entrega Relatórios';
      default:
        return 'Controle de Aprovação'; // Caso o setRot não corresponda
    }
  }
}
