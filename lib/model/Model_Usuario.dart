class Model_Usuario {
  static late String _username;
  static late String _password;
  static late String _codUsu;
  static late int _codEmp;


  String get codUsu => _codUsu;

  set codUsu(String value) {
    _codUsu = value;
  }

  String get username => _username;

  set SetUsername(String value) {
    _username = value;
  }

  String get password => _password;

  int get codEmp => _codEmp;

  set SetCodEmp(int value) {
    _codEmp = value;
  }

  set SetPassword(String value) {
    _password = value;
  }
}