import 'package:controle_aprovacao/model/Model_ModulosContratados.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> BuscarRotinas() async {
  Model_ModulosContratados mod = Model_ModulosContratados();
  Model_Parametro p = Model_Parametro();

  debugPrint("BuscarRotinas() - inicio");

  FirebaseFirestore.instance.collection('routines').get().then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      debugPrint("Modulos  - Inicio");
      debugPrint(docSnapshot.data().toString());
      debugPrint("Modulos - Fim");

      var cod3 = docSnapshot.data().remove('Requisição').toString();
      debugPrint("Requisicao: $cod3");

      var cod6 = docSnapshot.data().remove('Solicitação de Compra').toString();
      var cod9 = docSnapshot.data().remove('Cotação').toString();
      var cod12 = docSnapshot.data().remove('Ordem de Compra').toString();
      var cod15 = docSnapshot.data().remove('Contrato de Compra').toString();
      var cod18 =
          docSnapshot.data().remove('Nota Fiscal de Entrada').toString();
      var cod21 = docSnapshot.data().remove('Fatura de Compra').toString();
      var cod24 =
          docSnapshot.data().remove('Contas a Pagar - Entrada').toString();
      var cod27 =
          docSnapshot.data().remove('Contas a Pagar - Baixa').toString();
      var cod28 = docSnapshot
          .data()
          .remove('Contas a Pagar - Pagamento Eletrônico')
          .toString();
      var cod30 = docSnapshot.data().remove('Pedido de Venda').toString();
      var cod31 =
          docSnapshot.data().remove('Pedido de Venda Avalista').toString();
      var cod33 = docSnapshot.data().remove('Pré-Fatura').toString();
      var cod36 = docSnapshot.data().remove('Contrato de Venda').toString();
      var cod39 = docSnapshot.data().remove('Nota Fiscal de Venda').toString();
      var cod42 = docSnapshot.data().remove('Fatura de Venda').toString();
      var cod45 =
          docSnapshot.data().remove('Contas a Receber - Entrada').toString();
      var cod48 =
          docSnapshot.data().remove('Contas a Receber - Baixa').toString();
      var cod51 = docSnapshot.data().remove('Tesouraria').toString();
      var cod54 = docSnapshot.data().remove('Projeto').toString();
      var cod57 =
          docSnapshot.data().remove('Orçamento Produto/Serviço').toString();
      var cod60 = docSnapshot
          .data()
          .remove('Análise de Crédito - Central de Crédito')
          .toString();
      var cod61 = docSnapshot
          .data()
          .remove('Análise de Crédito - Crediário')
          .toString();
      var cod63 = docSnapshot
          .data()
          .remove('Controle Adiantamento - Solicitação')
          .toString();
      var cod64 = docSnapshot
          .data()
          .remove('Controle Adiantamento - Prestação Contas')
          .toString();
      var cod66 =
          docSnapshot.data().remove('Registro Ocorrência - Entrada').toString();
      var cod67 =
          docSnapshot.data().remove('Registro Ocorrência - Baixa').toString();
      var cod68 = docSnapshot
          .data()
          .remove('Registro Ocorrência - Flexibilização')
          .toString();
      var cod69 = docSnapshot.data().remove('Entrega Relatórios').toString();

      //aqui
      debugPrint("GetCli:${p.GetCli}");
      if (cod3.contains('\'${p.GetCli}\'')) {
        mod.cod3 = true;
        mod.rotNap = '3';
        mod.totalModulos++;
      }
      if (cod6.contains('\'${p.GetCli}\'')) {
        mod.cod6 = true;
        mod.rotNap = '6';
        mod.totalModulos++;
      }
      if (cod9.contains('\'${p.GetCli}\'')) {
        mod.cod9 = true;
        mod.rotNap = '9';
        mod.totalModulos++;
      }
      if (cod12.contains('\'${p.GetCli}\'')) {
        mod.cod12 = true;
        mod.rotNap = '12';
        mod.totalModulos++;
      }
      if (cod15.contains('\'${p.GetCli}\'')) {
        mod.cod15 = true;
        mod.rotNap = '15';
        mod.totalModulos++;
      }
      if (cod18.contains('\'${p.GetCli}\'')) {
        mod.cod18 = true;
        mod.rotNap = '18';
        mod.totalModulos++;
      }
      if (cod21.contains('\'${p.GetCli}\'')) {
        mod.cod21 = true;
        mod.rotNap = '21';
        mod.totalModulos++;
      }
      if (cod24.contains('\'${p.GetCli}\'')) {
        mod.cod24 = true;
        mod.rotNap = '24';
        mod.totalModulos++;
      }
      if (cod27.contains('\'${p.GetCli}\'')) {
        mod.cod27 = true;
        mod.rotNap = '27';
        mod.totalModulos++;
      }
      if (cod28.contains('\'${p.GetCli}\'')) {
        mod.cod28 = true;
        mod.rotNap = '28';
        mod.totalModulos++;
      }
      if (cod30.contains('\'${p.GetCli}\'')) {
        mod.cod30 = true;
        mod.rotNap = '30';
        mod.totalModulos++;
      }
      if (cod31.contains('\'${p.GetCli}\'')) {
        mod.cod31 = true;
        mod.rotNap = '31';
        mod.totalModulos++;
      }
      if (cod33.contains('\'${p.GetCli}\'')) {
        mod.cod33 = true;
        mod.rotNap = '33';
        mod.totalModulos++;
      }
      if (cod36.contains('\'${p.GetCli}\'')) {
        mod.cod36 = true;
        mod.rotNap = '36';
        mod.totalModulos++;
      }
      if (cod39.contains('\'${p.GetCli}\'')) {
        mod.cod39 = true;
        mod.rotNap = '39';
        mod.totalModulos++;
      }
      if (cod42.contains('\'${p.GetCli}\'')) {
        mod.cod42 = true;
        mod.rotNap = '42';
        mod.totalModulos++;
      }
      if (cod45.contains('\'${p.GetCli}\'')) {
        mod.cod45 = true;
        mod.rotNap = '45';
        mod.totalModulos++;
      }
      if (cod48.contains('\'${p.GetCli}\'')) {
        mod.cod48 = true;
        mod.rotNap = '48';
        mod.totalModulos++;
      }
      if (cod51.contains('\'${p.GetCli}\'')) {
        mod.cod51 = true;
        mod.rotNap = '51';
        mod.totalModulos++;
      }
      if (cod54.contains('\'${p.GetCli}\'')) {
        mod.cod54 = true;
        mod.rotNap = '54';
        mod.totalModulos++;
      }
      if (cod57.contains('\'${p.GetCli}\'')) {
        mod.cod57 = true;
        mod.rotNap = '57';
        mod.totalModulos++;
      }
      if (cod60.contains('\'${p.GetCli}\'')) {
        mod.cod60 = true;
        mod.rotNap = '60';
        mod.totalModulos++;
      }
      if (cod61.contains('\'${p.GetCli}\'')) {
        mod.cod61 = true;
        mod.rotNap = '61';
        mod.totalModulos++;
      }
      if (cod63.contains('\'${p.GetCli}\'')) {
        mod.cod63 = true;
        mod.rotNap = '63';
        mod.totalModulos++;
      }
      if (cod64.contains('\'${p.GetCli}\'')) {
        mod.cod64 = true;
        mod.rotNap = '64';
        mod.totalModulos++;
      }
      if (cod66.contains('\'${p.GetCli}\'')) {
        mod.cod66 = true;
        mod.rotNap = '66';
        mod.totalModulos++;
      }
      if (cod67.contains('\'${p.GetCli}\'')) {
        mod.cod67 = true;
        mod.rotNap = '67';
        mod.totalModulos++;
      }
      if (cod68.contains('\'${p.GetCli}\'')) {
        mod.cod68 = true;
        mod.rotNap = '68';
        mod.totalModulos++;
      }
      if (cod69.contains('\'${p.GetCli}\'')) {
        mod.cod69 = true;
        mod.rotNap = '69';
        mod.totalModulos++;
      }
    }

    debugPrint("BuscarRotinas() - fim");

    (e) {
      debugPrint("BuscarRotinas() - critica");
      debugPrint(e);
    };
  });
}
