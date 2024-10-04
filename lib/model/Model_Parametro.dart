import 'package:cloud_firestore/cloud_firestore.dart';

class Model_Parametro {
  static late String _Url;
  static late String _Server;
  static late String _Cli;

  String get GetUrl => _Url;

  set Url(String value) {
    _Url = value;
    String newValue = value.replaceAll(' ', '');
    newValue = newValue.replaceAll(
        '/g5-senior-services/sapiens_SyncMCWFUsers?wsdl', '');
    // newValue = newValue.replaceAll('http://', '');
    _Server = newValue;
  }

  String get GetCli => _Cli;

  set Cli(String value) {
    _Cli = value;
  }

  String get GetServer => _Server;
}
