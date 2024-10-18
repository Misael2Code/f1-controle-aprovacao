import 'package:flutter/material.dart';

void showInformation(BuildContext context, String routine) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                      Color.fromRGBO(44, 47, 87, 100),
                      Color.fromRGBO(1, 73, 172, 100)
                      //Color.fromRGBO(1, 73, 172, 100)
                    ]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            child: validationRoutine(routine));
      });
}

Widget validationRoutine(String routine) {
  switch (routine) {
    case 'APR':
      return buildPendentes();
    case 'CAN':
      return buildPendentes();
    default:
      return buildPendentes();
  }
}

Widget buildPendentes() {
  Color colorTitle = const Color.fromRGBO(18, 47, 76, 1);
  Color colorSubTitle = const Color.fromRGBO(18, 47, 76, 1);
  Color colorContent = Colors.black87;
  double sizeTitle = 26;
  double sizeSubTitle = 22;
  double sizeContent = 16;

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informações',
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: <Color>[Colors.black12, Colors.black12]),
                border: Border.all(color: Colors.black12),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(48),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(48))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Conceito",
                  style: TextStyle(color: colorTitle, fontSize: sizeTitle),
                ),
                Text(
                  'Aqui você encontra os documentos que ainda aguardam aprovação. Esta tela inclui todas as rotinas (como solicitações de compra e cotações) que ainda não foram analisadas.',
                  style: TextStyle(color: colorContent, fontSize: sizeContent),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Funcionalidades",
            style: TextStyle(color: colorSubTitle, fontSize: sizeSubTitle),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right_rounded),
              Expanded(
                child: Text(
                  'Aprovar/Reprovar Documentos: Selecione um documento para visualizar suas informações e escolher entre aprovar ou reprovar.',
                  style: TextStyle(color: colorContent, fontSize: sizeContent),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right_rounded),
              Expanded(
                child: Text(
                  'Organizar Documentos: Ordene por tipo ou data para facilitar o processo de revisão.',
                  style: TextStyle(color: colorContent, fontSize: sizeContent),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
