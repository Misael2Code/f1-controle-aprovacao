import 'package:flutter/material.dart';

void showInformation(
    BuildContext context, String situation, String routine, double sizeHeight) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: sizeHeight,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            child: validationRoutine(situation, routine));
      });
}

Widget validationRoutine(String situation, String routine) {
  if (routine.isEmpty) {
    switch (situation) {
      case 'APR':
        return buildHelpConsulta('APR',
            'Esta tela exibe todos os documentos que foram aprovados hoje, incluindo requisições de compra, solicitações de compra, cotações de produtos, ordens de compra, etc.');
      case 'CAN':
        return buildHelpConsulta('CAN',
            'Esta tela lista todos os documentos que foram reprovados hoje. É útil para verificar rapidamente quais documentos não atenderam aos critérios de aprovação.');
      case 'ANA':
        return buildHelpConsulta('ANA',
            'Aqui você encontra os documentos que ainda aguardam aprovação. Esta tela inclui todos os documentos que ainda não foram analisados, como solicitações de compra, cotações, etc.');
      case 'AGP':
        return buildHelpProcess(
            'Nesta tela é possível visualizar o status referente a cada item processado.');
      default:
        return buildHelpModulo(
            'Esta tela contém todas as rotinas do ERP Senior que são passíveis de controle de aprovação.');
    }
  } else {
    return buildHelpItemDetail(routine);
  }
}

Widget buildHelpProcess(String concept) {
  Color colorMain = Colors.black;
  Color colorFuctions = Colors.black87;
  double sizeTitle = 22;
  double sizeContent = 16;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 5,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      Container(
          padding: const EdgeInsets.all(24),
          child: Image.asset(
            'image/logotipo.png',
            height: 48,
          )),
      Row(
        children: [
          const Icon(
            Icons.gpp_good,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              concept,
              style: TextStyle(
                  color: colorMain,
                  fontSize: sizeContent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          const SizedBox(
            width: 36,
          ),
          Expanded(
            child: Text(
              'Caso haja falha no processamento de algum item, processe-o individualmente para obter o detalhamento da falha ocorrida.',
              style: TextStyle(
                  color: colorMain,
                  fontSize: sizeContent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 3))
              ],
              color: Colors.blue[50],
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 36,
                    ),
                    Text(
                      'Legenda:',
                      style: TextStyle(
                          color: colorFuctions,
                          fontSize: sizeTitle,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 36,
                    ),
                    const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Text(
                      'Falha no processamento do item.',
                      style: TextStyle(
                          fontSize: sizeContent, fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 36,
                    ),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Text(
                      'Sucesso no processamento do item.',
                      style: TextStyle(
                          fontSize: sizeContent, fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildHelpModulo(String concept) {
  Color colorMain = Colors.black;
  Color colorFuctions = Colors.black87;
  double sizeTitle = 22;
  double sizeContent = 16;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 5,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      Container(
          padding: const EdgeInsets.all(24),
          child: Image.asset(
            'image/logotipo.png',
            height: 48,
          )),
      Row(
        children: [
          const Icon(
            Icons.gpp_good,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              concept,
              style: TextStyle(
                  color: colorMain,
                  fontSize: sizeContent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          const SizedBox(
            width: 36,
          ),
          Expanded(
            child: Text(
              'As rotinas ativas para o seu contrato estão destacadas, enquanto as demais estão em branco.',
              style: TextStyle(
                  color: colorMain,
                  fontSize: sizeContent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 3))
              ],
              color: Colors.blue[50],
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 36,
                    ),
                    Text(
                      'Funcionalidades:',
                      style: TextStyle(
                          color: colorFuctions,
                          fontSize: sizeTitle,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                buildFuctions(
                    36,
                    Icons.grid_view_outlined,
                    12,
                    'Clicando no botão "Todas as Rotinas" você será direcionado para a tela principal do aplicativo, e visualizará todos os documentos de todas as rotinas que estão na sua alçada de aprovação.',
                    sizeContent,
                    colorFuctions),
                const SizedBox(
                  height: 12,
                ),
                buildFuctions(
                    36,
                    Icons.ads_click,
                    12,
                    'Os demais botões funcionam como um filtro para as telas de "Aprovadas", "Pendentes" e "Reprovadas".',
                    sizeContent,
                    colorFuctions),
                const SizedBox(
                  height: 12,
                ),
                buildFuctions(
                    36,
                    Icons.info_outline,
                    12,
                    'Para ter acesso ao controle de aprovação de mais rotinas, entre em contato com o nosso comercial.',
                    sizeContent,
                    colorFuctions),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildHelpItemDetail(String routine) {
  double sizeContent = 16;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 5,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      Container(
          padding: const EdgeInsets.all(24),
          child: Image.asset(
            'image/logotipo.png',
            height: 48,
          )),
      if (routine.contains('REQUISIÇÃO')) ...[
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Se uma requisição for aprovada ou reprovada, não é possível desfazer a operação.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'É possível reprovar uma requisição, ainda que esteja aprovada, desde que seja feito no mesmo dia se sua aprovação.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Não é possível aprovar uma requisição se estiver cancelada.',
            sizeContent),
      ] else if (routine.contains('SOLICITAÇÃO DE COMPRA')) ...[
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Se uma solicitação de compra for aprovada ou reprovada, não é possível desfazer a operação.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Não é possível cancelar uma solicitação de compra aprovada:',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            const SizedBox(
              width: 28,
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                'Pois ficará travada em processo de aprovação; ou',
                style: TextStyle(
                    fontSize: sizeContent,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 28,
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                'Se for originada de um movimento de estoque (requisição).',
                style: TextStyle(
                    fontSize: sizeContent,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'É possível aprovar uma solicitação de compra cancelada que não foi originada de um movimento de estoque (requisição).',
            sizeContent),
      ] else if (routine.contains('COTAÇÃO')) ...[
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Se uma cotação for aprovada ou reprovada, não é possível desfazer a operação.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Não é possível aprovar uma cotação se estiver reprovada.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Não é possível reprovar uma cotação se estiver aprovada.',
            sizeContent),
      ] else if (routine.contains('ORDEM DE COMPRA')) ...[
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Se uma ordem de compra for aprovada ou reprovada, não é possível desfazer a operação.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Não é possível aprovar uma ordem de compra se estiver reprovada.',
            sizeContent),
        const SizedBox(
          height: 12,
        ),
        buildActions(
            Icons.arrow_circle_right,
            12,
            'Não é possível reprovar uma ordem de compra se estiver aprovada.',
            sizeContent),
      ]
    ],
  );
}

Widget buildHelpConsulta(String situation, String concept) {
  Color colorMain = Colors.black;
  Color colorFuctions = Colors.black87;
  double sizeTitle = 22;
  double sizeContent = 16;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 5,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      Container(
          padding: const EdgeInsets.all(24),
          child: Image.asset(
            'image/logotipo.png',
            height: 48,
          )),
      Row(
        children: [
          const Icon(
            Icons.gpp_good,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              concept,
              style: TextStyle(
                  color: colorMain,
                  fontSize: sizeContent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 3))
              ],
              color: Colors.blue[50],
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 36,
                    ),
                    Text(
                      'Funcionalidades:',
                      style: TextStyle(
                          color: colorFuctions,
                          fontSize: sizeTitle,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                buildFuctions(
                    36,
                    Icons.touch_app,
                    12,
                    'Dê um clique em um documento para visualizar suas informações e escolher entre aprovar ou reprovar, se possível.',
                    sizeContent,
                    colorFuctions),
                const SizedBox(
                  height: 12,
                ),
                buildFuctions(
                    36,
                    Icons.ads_click,
                    12,
                    'Pressione um documento para selecioná-lo, possibilitando a aprovação ou reprovação de forma agrupada, quando for possível.',
                    sizeContent,
                    colorFuctions),
                const SizedBox(
                  height: 12,
                ),
                buildFuctions(
                    36,
                    Icons.playlist_add_circle,
                    12,
                    'Qualquer documento, mesmo que esteja selecionado, pode ser visualizado apenas com um clique simples sobre ele.',
                    sizeContent,
                    colorFuctions),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildFuctions(double widthToIcon, IconData icon, double space,
    String text, double sizeContent, Color colorFuctions) {
  return Row(
    children: [
      SizedBox(
        width: widthToIcon,
      ),
      Icon(
        icon,
        color: Colors.black87,
      ),
      SizedBox(
        width: space,
      ),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: sizeContent, color: colorFuctions),
        ),
      )
    ],
  );
}

Widget buildActions(
    IconData icon, double space, String text, double sizeContent) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.blue,
      ),
      SizedBox(
        width: space,
      ),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              fontSize: sizeContent,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
