class NaviManager {
  factory NaviManager() => _getInstance();
  static NaviManager get instance => _getInstance();
  static NaviManager _instance;
  NaviManager._internal() {}
  static NaviManager _getInstance() {
    if (_instance == null) {
      _instance = new NaviManager._internal();
    }
    return _instance;
  }

  String savedPage;
}
