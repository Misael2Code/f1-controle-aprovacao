import 'package:ControleAprovacao/components/showInformation.dart';
import 'package:flutter/material.dart';
import 'package:ControleAprovacao/model/Model_ModulosContratados.dart';
import 'package:ControleAprovacao/paginas/Controles.dart';

class Modulos extends StatefulWidget {
  const Modulos({super.key});

  @override
  State createState() => _ModulosState();
}

class _ModulosState extends State<Modulos> {
  final Model_ModulosContratados mod = Model_ModulosContratados();
  double fontSize = 12;
  double heightItem = 140;
  double paddingButton = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButtonsInformation(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildButton('Todas as Rotinas', Icons.grid_view_outlined, () {
              mod.rotNapSelect = mod.rotNap;
              mod.setRot = 0;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Controles(setRot: 0)));
            }),
            _buildSectionTitle('Suprimentos'),
            Row(
              children: [
                _buildModuleButton(
                    mod.cod3, 'Requisição', '', Icons.note_alt_outlined, 3),
                _buildModuleButton(mod.cod6, 'Solicitação de Compra', '',
                    Icons.production_quantity_limits_outlined, 6),
                _buildModuleButton(mod.cod9, 'Cotação', '',
                    Icons.shopping_cart_checkout_outlined, 9),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(mod.cod12, 'Ordem de Compra', '',
                    Icons.add_shopping_cart_outlined, 12),
                _buildModuleButton(
                    mod.cod15, 'Contrato de Compra', '', Icons.handshake, 15),
                _buildModuleButton(mod.cod18, 'Nota Fiscal de Entrada', '',
                    Icons.sticky_note_2_outlined, 18),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(mod.cod21, 'Fatura de Compra', '',
                    Icons.request_page_outlined, 21),
                Expanded(flex: 3, child: Container()),
                Expanded(flex: 3, child: Container()),
              ],
            ),
            _buildSectionTitle('Mercado'),
            Row(
              children: [
                _buildModuleButton(mod.cod30, 'Pedido de Venda', '',
                    Icons.shopping_bag_outlined, 30),
                _buildModuleButton(mod.cod31, 'Pedido de Venda', 'Avalista',
                    Icons.shopping_bag, 31),
                _buildModuleButton(mod.cod33, 'Pré-Fatura', '',
                    Icons.account_balance_wallet_outlined, 33),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(
                    mod.cod42, 'Fatura de Venda', '', Icons.request_quote, 42),
                _buildModuleButton(mod.cod36, 'Contrato de Venda', '',
                    Icons.handshake_outlined, 36),
                _buildModuleButton(mod.cod39, 'Nota Fiscal de Saída', '',
                    Icons.my_library_books_outlined, 39),
              ],
            ),
            _buildSectionTitle('Finanças'),
            Row(
              children: [
                _buildModuleButton(mod.cod51, 'Tesouraria', '',
                    Icons.price_change_rounded, 51),
                _buildModuleButton(mod.cod45, 'Contas a Receber', 'Entrada',
                    Icons.monetization_on_outlined, 45),
                _buildModuleButton(mod.cod48, 'Contas a Receber', 'Baixa',
                    Icons.price_check_outlined, 48),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(mod.cod24, 'Contas a Pagar', 'Entrada',
                    Icons.payments_outlined, 24),
                _buildModuleButton(
                    mod.cod27, 'Contas a Pagar', 'Baixa', Icons.payments, 27),
                _buildModuleButton(mod.cod28, 'Contas a Pagar',
                    'Pagamento Eletrônico', Icons.paypal_outlined, 28),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(mod.cod63, 'Controle de Adiantamento',
                    'Solicitação', Icons.addchart_outlined, 63),
                _buildModuleButton(mod.cod64, 'Controle de Adiantamento',
                    'Prestação Contas', Icons.insert_chart_outlined, 64),
                _buildModuleButton(mod.cod54, 'Projeto', '',
                    Icons.snippet_folder_outlined, 54),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(mod.cod66, 'Registro de Ocorrência',
                    'Entrada', Icons.inbox_rounded, 66),
                _buildModuleButton(mod.cod67, 'Registro de Ocorrência', 'Baixa',
                    Icons.move_to_inbox_rounded, 67),
                _buildModuleButton(mod.cod68, 'Registro de Ocorrência',
                    'Flexibilização', Icons.all_inbox, 68),
              ],
            ),
            Row(
              children: [
                _buildModuleButton(
                    mod.cod69, 'Entrega Relatório', '', Icons.pie_chart, 69),
                Expanded(flex: 3, child: Container()),
                Expanded(flex: 3, child: Container()),
              ],
            ),
          ],
        ),
      ),
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
                showInformation(context, '', '', 650);
              }),
        ],
      ),
    );
  }

  Widget _buildButton(String title, IconData icon, VoidCallback onPressed) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: heightItem / 3.25,
            padding: const EdgeInsets.all(2),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromRGBO(0, 74, 173, 100)),
              ),
              onPressed: onPressed,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(icon, color: Colors.white70),
                        Text(title,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const Icon(Icons.navigate_next, color: Colors.white70),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(2),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildModuleButton(bool isEnabled, String title, String subtitle,
      IconData icon, int setRot) {
    late Color iconColor;
    late Color nextColor;
    late Color textColor;
    late Color backColor;

    switch (isEnabled) {
      case true:
        iconColor = Colors.white70;
        nextColor = Colors.white70;
        textColor = Colors.white;
        backColor = const Color.fromRGBO(
            0, 74, 173, 100); //const Color.fromRGBO(0, 74, 173, 100);
        break;
      case false:
        iconColor = Colors.blue;
        nextColor = Colors.blue;
        textColor = Colors.black;
        backColor = Colors.white;
        break;
    }
    return Expanded(
      flex: 3,
      child: Container(
        height: heightItem,
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(2),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: WidgetStateProperty.all(backColor),
          ),
          onPressed: isEnabled
              ? () {
                  mod.rotNapSelect = setRot.toString();
                  mod.setRot = setRot;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Controles(setRot: setRot)));
                }
              : null,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: iconColor),
                    Icon(Icons.navigate_next, color: nextColor),
                  ],
                ),
                Wrap(
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: fontSize,
                            color: textColor,
                            fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: fontSize,
                            color: textColor,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
