import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_ModulosContratados.dart';
import 'package:ControleAprovacao/paginas/Controles.dart';

class Modulos extends StatefulWidget {
  const Modulos({Key? key}) : super(key: key);

  @override
  State<Modulos> createState() => _ModulosState();
}

class _ModulosState extends State<Modulos> {
  @override
  Widget build(BuildContext context) {
    Model_ModulosContratados mod = Model_ModulosContratados();
    double fontSize = 12;
    double top = 6;
    double bottom = 6;
    double left = 0;
    double right = 0;
    double paddingButton = 2;
    double heightItem = 140;
    double espaceSubtitle = 15;
    double espacePosSubtitle = 5;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: heightItem / 3.25,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromRGBO(0, 74, 173, 100))),
                        onPressed: () {
                          Model_ModulosContratados().rotNapSelect =
                              Model_ModulosContratados().rotNap;
                          mod.setRot = 0;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Controles()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.grid_view_outlined,
                                    color: Colors.white,
                                  ),
                                  Text('Todos os Módulos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: espaceSubtitle,
            ),
            Container(
              padding: const EdgeInsets.all(2),
              child: const Text(
                'Mercado',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: espacePosSubtitle,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod30
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '30';
                                mod.setRot = 30;
                                TitlePage().titlePage = 'Pedido de Venda';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.shopping_bag_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pedido de Venda',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod31
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '31';
                                mod.setRot = 31;
                                TitlePage().titlePage =
                                    'Pedido de Venda - Avalista';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.shopping_bag, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pedido de Venda',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Avalista',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod33
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '33';
                                mod.setRot = 33;
                                TitlePage().titlePage = 'Pré-Fatura';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.account_balance_wallet_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pré-Fatura',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod42
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '42';
                                mod.setRot = 42;
                                TitlePage().titlePage = 'Fatura de Venda';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.request_quote, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fatura de Venda',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod36
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '36';
                                mod.setRot = 36;
                                TitlePage().titlePage = 'Contrato de Venda';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.handshake_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contrato de Venda',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod39
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '39';
                                mod.setRot = 39;
                                TitlePage().titlePage = 'Nota Fiscal de Saída';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.my_library_books_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nota Fiscal de Saída',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod57
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '57';
                                mod.setRot = 57;
                                TitlePage().titlePage =
                                    'Orçamento Produto/Serviço';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.construction_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Orçamento Produto/Serviço',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod60
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '60';
                                mod.setRot = 60;
                                TitlePage().titlePage =
                                    'Análise de Crédito - Central de Crédito';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.assured_workload_rounded,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Análise de Crédito',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Central de Crédito',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod61
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '61';
                                mod.setRot = 61;
                                TitlePage().titlePage =
                                    'Análise de Crédito - Crediário';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.account_balance,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Análise de Crédito',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Crediário',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: espaceSubtitle,
            ),
            Container(
              padding: const EdgeInsets.all(2),
              child: const Text(
                'Suprimentos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: espacePosSubtitle,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod3
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '3';
                                mod.setRot = 3;
                                TitlePage().titlePage = 'Requisição';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.note_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Requisição',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod6
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '6';
                                mod.setRot = 6;
                                TitlePage().titlePage = 'Solicitação de Compra';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                      Icons.production_quantity_limits_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Solicitação de Compra',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod9
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '9';
                                mod.setRot = 9;
                                TitlePage().titlePage = 'Cotação';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.shopping_cart_checkout_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Cotação',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod12
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '12';
                                mod.setRot = 12;
                                TitlePage().titlePage = 'Ordem de Compra';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.add_shopping_cart_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Ordem de Compra',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod15
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '15';
                                mod.setRot = 15;
                                TitlePage().titlePage = 'Contrato de Compra';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.handshake, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Contrato de Compra',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod18
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '18';
                                mod.setRot = 18;
                                TitlePage().titlePage =
                                    'Nota Fiscal de Entrada';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.sticky_note_2_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Nota Fiscal de Entrada',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod21
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '21';
                                mod.setRot = 21;
                                TitlePage().titlePage = 'Fatura de Compra';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.request_page_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Text('Fatura de Compra',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
              ],
            ),
            SizedBox(
              height: espaceSubtitle,
            ),
            Container(
              padding: const EdgeInsets.all(2),
              child: const Text(
                'Finanças',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: espacePosSubtitle,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod51
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '51';
                                mod.setRot = 51;
                                TitlePage().titlePage = 'Tesouraria';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.price_change_rounded,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tesouraria',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod45
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '45';
                                mod.setRot = 45;
                                TitlePage().titlePage =
                                    'Contas a Receber - Entrada';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.monetization_on_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contas a Receber',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Entrada',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod48
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '48';
                                mod.setRot = 48;
                                TitlePage().titlePage =
                                    'Contas a Receber - Baixa';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.price_check_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contas a Receber',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Baixa',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod24
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '24';
                                mod.setRot = 24;
                                TitlePage().titlePage =
                                    'Contas a Pagar - Entrada';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.payments_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contas a Pagar',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Entrada',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod27
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '27';
                                mod.setRot = 27;
                                TitlePage().titlePage =
                                    'Contas a Pagar - Baixa';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.payments, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contas a Pagar',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Baixa',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod28
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '28';
                                mod.setRot = 28;
                                TitlePage().titlePage =
                                    'Contas a Pagar - Pagamento Eletrônico';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.paypal_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contas a Pagar',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Pagamento Eletrônico',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod63
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '63';
                                mod.setRot = 63;
                                TitlePage().titlePage =
                                    'Controle de Adiantamento - Solicitação';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.addchart_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Controle de Adiantamento',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Solicitação',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod64
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '64';
                                mod.setRot = 64;
                                TitlePage().titlePage =
                                    'Controle de Adiantamento - Prestação de Contas';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.insert_chart_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Controle de Adiantamento',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Prestação de Contas',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod54
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '54';
                                mod.setRot = 54;
                                TitlePage().titlePage = 'Projeto';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.snippet_folder_outlined,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Projeto',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod66
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '66';
                                mod.setRot = 66;
                                TitlePage().titlePage =
                                    'Registro de Ocorrência - Entrada';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.inbox_rounded, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Registro Ocorrência',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Entrada',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod67
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '67';
                                mod.setRot = 67;
                                TitlePage().titlePage =
                                    'Registro de Ocorrência - Baixa';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.move_to_inbox_rounded,
                                      color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Registro Ocorrência',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Baixa',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod68
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '68';
                                mod.setRot = 68;
                                TitlePage().titlePage =
                                    'Registro de Ocorrência - Flexibilização';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.all_inbox, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Registro Ocorrência',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('Flexibilização',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: heightItem,
                    padding: EdgeInsets.all(paddingButton),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white)),
                        onPressed: mod.cod69
                            ? () {
                                Model_ModulosContratados().rotNapSelect = '69';
                                mod.setRot = 69;
                                TitlePage().titlePage = 'Entrega de Relatórios';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Controles()));
                              }
                            : null,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(left, top, right, bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.pie_chart, color: Colors.blue),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Entrega Relatórios',
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(flex: 3, child: Container()),
                Expanded(flex: 3, child: Container()),
              ],
            )
          ],
        ),
      ),
    );
/*
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, __) => [
                const SliverAppBar(
                  title: Text('Suprimentos'),
                )
              ],
          body: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            children: [
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(0, 74, 173, 100))),
                    onPressed: () {
                      Model_ModulosContratados().rotNapSelect =
                          Model_ModulosContratados().rotNap;
                      mod.setRot = 0;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Controles()));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.grid_view_outlined,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Text('Todos',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod3
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '3';
                            mod.setRot = 3;
                            TitlePage().titlePage = 'Requisição';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                color: Colors.blue,
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Requisição',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod6
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '6';
                            mod.setRot = 6;
                            TitlePage().titlePage = 'Solicitação de Compra';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.production_quantity_limits_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Solicitação de Compra',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod9
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '9';
                            mod.setRot = 9;
                            TitlePage().titlePage = 'Cotação';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.shopping_cart_checkout_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Cotação',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod12
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '12';
                            mod.setRot = 12;
                            TitlePage().titlePage = 'Ordem de Compra';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.add_shopping_cart_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Ordem de Compra',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod15
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '15';
                            mod.setRot = 15;
                            TitlePage().titlePage = 'Contrato de Compra';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.handshake, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Contrato de Compra',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod18
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '18';
                            mod.setRot = 18;
                            TitlePage().titlePage = 'Nota Fiscal de Entrada';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.sticky_note_2_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Nota Fiscal de Entrada',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod21
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '21';
                            mod.setRot = 21;
                            TitlePage().titlePage = 'Fatura de Compra';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.request_page_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text('Fatura de Compra',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod24
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '24';
                            mod.setRot = 24;
                            TitlePage().titlePage = 'Contas a Pagar - Entrada';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.payments_outlined, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contas a Pagar',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Entrada',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod27
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '27';
                            mod.setRot = 27;
                            TitlePage().titlePage = 'Contas a Pagar - Baixa';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.payments, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contas a Pagar',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Baixa',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod28
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '28';
                            mod.setRot = 28;
                            TitlePage().titlePage =
                                'Contas a Pagar - Pagamento Eletrônico';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.paypal_outlined, color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Contas a Pagar',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Pagamento Eletrônico',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod30
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '30';
                            mod.setRot = 30;
                            TitlePage().titlePage = 'Pedido de Venda';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.shopping_bag_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pedido de Venda',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod31
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '31';
                            mod.setRot = 31;
                            TitlePage().titlePage =
                                'Pedido de Venda - Avalista';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.shopping_bag, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pedido de Venda',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Avalista',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod33
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '33';
                            mod.setRot = 33;
                            TitlePage().titlePage = 'Pré-Fatura';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.account_balance_wallet_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pré-Fatura',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod36
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '36';
                            mod.setRot = 36;
                            TitlePage().titlePage = 'Contrato de Venda';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.handshake_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contrato de Venda',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod39
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '39';
                            mod.setRot = 39;
                            TitlePage().titlePage = 'Nota Fiscal de Saída';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.my_library_books_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nota Fiscal de Saída',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod42
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '42';
                            mod.setRot = 42;
                            TitlePage().titlePage = 'Fatura de Venda';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.request_quote, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Fatura de Venda',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod45
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '45';
                            mod.setRot = 45;
                            TitlePage().titlePage =
                                'Contas a Receber - Entrada';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.monetization_on_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contas a Receber',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Entrada',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod48
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '48';
                            mod.setRot = 48;
                            TitlePage().titlePage = 'Contas a Receber - Baixa';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.price_check_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contas a Receber',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Baixa',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod51
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '51';
                            mod.setRot = 51;
                            TitlePage().titlePage = 'Tesouraria';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.price_change_rounded,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tesouraria',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod54
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '54';
                            mod.setRot = 54;
                            TitlePage().titlePage = 'Projeto';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.snippet_folder_outlined,
                                  color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Projeto',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod57
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '57';
                            mod.setRot = 57;
                            TitlePage().titlePage = 'Orçamento Produto/Serviço';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.construction_outlined,
                                    color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Orçamento Produto/Serviço',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod60
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '60';
                            mod.setRot = 60;
                            TitlePage().titlePage =
                                'Análise de Crédito - Central de Crédito';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.assured_workload_rounded,
                                    color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Análise de Crédito',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Central de Crédito',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod61
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '61';
                            mod.setRot = 61;
                            TitlePage().titlePage =
                                'Análise de Crédito - Crediário';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.account_balance, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Análise de Crédito',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Crediário',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod63
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '63';
                            mod.setRot = 63;
                            TitlePage().titlePage =
                                'Controle de Adiantamento - Solicitação';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.addchart_outlined,
                                    color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Controle de Adiantamento',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Solicitação',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod64
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '64';
                            mod.setRot = 64;
                            TitlePage().titlePage =
                                'Controle de Adiantamento - Prestação de Contas';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.insert_chart_outlined,
                                    color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Controle de Adiantamento',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Prestação de Contas',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod66
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '66';
                            mod.setRot = 66;
                            TitlePage().titlePage =
                                'Registro de Ocorrência - Entrada';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.inbox_rounded, color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Registro Ocorrência',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Entrada',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod67
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '67';
                            mod.setRot = 67;
                            TitlePage().titlePage =
                                'Registro de Ocorrência - Baixa';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.move_to_inbox_rounded,
                                    color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Registro Ocorrência',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Baixa',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod68
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '68';
                            mod.setRot = 68;
                            TitlePage().titlePage =
                                'Registro de Ocorrência - Flexibilização';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.all_inbox, color: Colors.blue),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Registro Ocorrência',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('Flexibilização',
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(paddingButton),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: mod.cod69
                        ? () {
                            Model_ModulosContratados().rotNapSelect = '69';
                            mod.setRot = 69;
                            TitlePage().titlePage = 'Entrega de Relatórios';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Controles()));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.pie_chart, color: Colors.blue),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Entrega Relatórios',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );*/
  }
}
