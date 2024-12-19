import 'package:flutter/foundation.dart';

class Model_Parametro {
  static late String _Url;
  static late String _Server;
  static late String _Cli;

  String get GetUrl => _Url;

  set Url(String value) {
    debugPrint("Servidor: $value"); 

    _Url = value;
    String newValue = value.replaceAll(' ', '');
    newValue = newValue.replaceAll(
        '/g5-senior-services/sapiens_SyncMCWFUsers?wsdl', '');
    _Server = newValue;
  }

  String get GetCli => _Cli;

  set Cli(String value) {
    _Cli = value;

    debugPrint("Cliente: $_Cli");
  }

  String get GetServer => _Server;

  void clear() {
    _Url = '';
    _Server = '';
    _Cli = '';   
    debugPrint("Limpou Servidor: $_Url");  
    debugPrint("Limpou Cliente: $_Cli");  
  }
}
