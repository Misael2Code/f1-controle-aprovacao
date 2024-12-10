//Nao utilizando (usando dns informado via showdialog)

//import 'package:cloud_firestore/cloud_firestore.dart';

// class Model_Firebase {
//   static String _dns = '';

//   String get dns => _dns;

//   set dns(String value) {
//     _dns = value;
//   }
// }

// // find all DNS of database
// Future<String> getAllDnsFirebase() async {
//   var ret = '';
//   FirebaseFirestore.instance.collection('users').get().then((querySnapshot) {
//     for (var docSnapshot in querySnapshot.docs) {
//       Model_Firebase().dns = docSnapshot.data().toString();
//     }
//     onError:
//     (e) {
//       ret = 'Desculpe, estamos enfrentando problemas técnicos: $e';
//       return ret;
//     };
//   });
//   return ret;
// }
