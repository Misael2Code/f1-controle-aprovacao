import 'package:controle_aprovacao/model/Model_DNS.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/paginas/Login.dart';
import 'package:controle_aprovacao/requisicoes/Rest_ValidarDNS.dart';
import 'package:flutter/material.dart';
import 'package:controle_aprovacao/model/TabBarController.dart';
import 'package:controle_aprovacao/paginas/Modulos.dart';
import 'package:controle_aprovacao/paginas/Consultas.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 24),
                        Image.asset(
                          'image/logo_white.png',
                          height: 44,
                        ),
                        IconButton(
                            onPressed: () {
                              AlertDialog(
                                title: const Text('Deseja sair?'),
                                content: const Text(
                                    'Ao sair todos os seus dados de acesso serão apagados.'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop,
                                      child: const Text('Não')),
                                  TextButton(
                                      onPressed: () {
                                        disconnect();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      },
                                      child: const Text('Sair'))
                                ],
                              );
                              disconnect();
                            },
                            icon: const Icon(
                              Icons.exit_to_app,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getModuleTitle(
                              widget.setRot), // Usando o setRot do widget
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),*/
                    const SizedBox(
                      height: 12,
                    )
                  ],
                ),
                flexibleSpace: Container(
                  color: const Color.fromRGBO(1, 14, 33, 1),
                ),
                bottom: TabBar(
                  controller: tabController.controller,
                  indicatorColor: Colors.blueAccent,
                  isScrollable: false,
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: (width(context) -
                              (menuWidth(width(context)) +
                                  yourWidth(width(context),
                                          menuWidth(width(context))) *
                                      4)) /
                          8),
                  tabs: [
                    buildTab(Icons.grid_view_rounded, 'Rotinas', context,
                        tabController.controller.index),
                    buildTab(Icons.check_circle_outline, 'Aprovadas', context,
                        tabController.controller.index),
                    buildTab(Icons.error_outline_outlined, 'Pendentes', context,
                        tabController.controller.index),
                    buildTab(Icons.highlight_remove, 'Reprovadas', context,
                        tabController.controller.index),
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

  Widget buildTab(IconData icon, String text, BuildContext context, int index) {
    return SizedBox(
      width: menu(text, context),
      child: Tab(
        child: iconsAba(text, icon, index),
      ),
    );
  }

  Column iconsAba(String text, IconData icon, int index) {
    Color iconColor = Colors.white;
    Color textColor = Colors.white;

    switch (text) {
      case 'Aprovadas':
        if (index == 1) {
          iconColor = Colors.blue;
          textColor = Colors.blue;
        }
        return Column(
          children: [
            Icon(icon, color: iconColor),
            Text(text, style: TextStyle(fontSize: 14, color: textColor)),
          ],
        );
      case 'Pendentes':
        if (index == 2) {
          iconColor = Colors.blue;
          textColor = Colors.blue;
        }
        return Column(
          children: [
            Icon(icon, color: iconColor),
            Text(text, style: TextStyle(fontSize: 14, color: textColor)),
          ],
        );
      case 'Reprovadas':
        if (index == 3) {
          iconColor = Colors.blue;
          textColor = Colors.blue;
        }
        return Column(
          children: [
            Icon(icon, color: iconColor),
            Text(text, style: TextStyle(fontSize: 14, color: textColor)),
          ],
        );
      default:
        if (index == 0) {
          iconColor = Colors.blue;
          textColor = Colors.blue;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
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

  void disconnect() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    Model_Parametro par = Model_Parametro();
    p.clear();
    Model_DNS().DNS = '';
    par.Cli = '';
    par.Url = '';
    ResultadoDNS().conectado = false;
  }
}
