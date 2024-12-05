class Model_ModulosContratados {
  static bool _cod3  = false;
  static bool _cod6  = false;
  static bool _cod9  = false;
  static bool _cod12 = false;
  static bool _cod15 = false;
  static bool _cod18 = false;
  static bool _cod21 = false;
  static bool _cod24 = false;
  static bool _cod27 = false;
  static bool _cod28 = false;
  static bool _cod30 = false;
  static bool _cod31 = false;
  static bool _cod33 = false;
  static bool _cod36 = false;
  static bool _cod39 = false;
  static bool _cod42 = false;
  static bool _cod45 = false;
  static bool _cod48 = false;
  static bool _cod51 = false;
  static bool _cod54 = false;
  static bool _cod57 = false;
  static bool _cod60 = false;
  static bool _cod61 = false;
  static bool _cod63 = false;
  static bool _cod64 = false;
  static bool _cod66 = false;
  static bool _cod67 = false;
  static bool _cod68 = false;
  static bool _cod69 = false;
  static int  _totalModulos = 0;
  static int  _setRot = 0;
  static String _rotNap = '';
  static String _rotNapSelect = '';

  bool get cod3 => _cod3;

  bool get cod6 => _cod6;

  bool get cod9 => _cod9;

  bool get cod12 => _cod12;

  bool get cod15 => _cod15;

  bool get cod18 => _cod18;

  bool get cod21 => _cod21;

  bool get cod24 => _cod24;

  bool get cod27 => _cod27;

  bool get cod28 => _cod28;

  bool get cod30 => _cod30;

  bool get cod31 => _cod31;

  bool get cod33 => _cod33;

  bool get cod36 => _cod36;

  bool get cod39 => _cod39;

  bool get cod42 => _cod42;

  bool get cod45 => _cod45;

  bool get cod48 => _cod48;

  bool get cod51 => _cod51;

  bool get cod54 => _cod54;

  bool get cod57 => _cod57;

  bool get cod60 => _cod60;

  bool get cod61 => _cod61;

  bool get cod63 => _cod63;

  bool get cod64 => _cod64;

  bool get cod66 => _cod66;

  bool get cod67 => _cod67;

  bool get cod68 => _cod68;

  bool get cod69 => _cod69;

  int get totalModulos => _totalModulos;

  int get setRot => _setRot;

  String get rotNap => _rotNap;

  String get rotNapSelect => _rotNapSelect;


  set cod3(bool value) {
    _cod3 = value;
  }

  set cod6(bool value) {
    _cod6 = value;
  }

  set cod9(bool value) {
    _cod9 = value;
  }

  set cod12(bool value) {
    _cod12 = value;
  }

  set cod15(bool value) {
    _cod15 = value;
  }

  set cod18(bool value) {
    _cod18 = value;
  }

  set cod21(bool value) {
    _cod21 = value;
  }

  set cod24(bool value) {
    _cod24 = value;
  }

  set cod27(bool value) {
    _cod27 = value;
  }

  set cod28(bool value) {
    _cod28 = value;
  }

  set cod30(bool value) {
    _cod30 = value;
  }

  set cod31(bool value) {
    _cod31 = value;
  }

  set cod33(bool value) {
    _cod33 = value;
  }

  set cod36(bool value) {
    _cod36 = value;
  }

  set cod39(bool value) {
    _cod39 = value;
  }

  set cod42(bool value) {
    _cod42 = value;
  }

  set cod45(bool value) {
    _cod45 = value;
  }

  set cod48(bool value) {
    _cod48 = value;
  }

  set cod51(bool value) {
    _cod51 = value;
  }

  set cod54(bool value) {
    _cod54 = value;
  }

  set cod57(bool value) {
    _cod57 = value;
  }

  set cod60(bool value) {
    _cod60 = value;
  }

  set cod61(bool value) {
    _cod61 = value;
  }

  set cod63(bool value) {
    _cod63 = value;
  }

  set cod64(bool value) {
    _cod64 = value;
  }

  set cod66(bool value) {
    _cod66 = value;
  }

  set cod67(bool value) {
    _cod67 = value;
  }

  set cod68(bool value) {
    _cod68 = value;
  }

  set cod69(bool value) {
    _cod69 = value;
  }

  set totalModulos(int value) {
    _totalModulos = value;
  }

  set setRot(int value) {
    _setRot = value;
  }

  set rotNap(String value) {
    if(_rotNap.isEmpty) {
      _rotNap = value;
    } else {
      _rotNap = '$_rotNap,$value';
    }
    _rotNapSelect = _rotNap;
  }

  set rotNapSelect(String value) {
    _rotNapSelect = value;
  }
}

