import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/service/networkService.dart';
import 'package:jessie_wish/common/service/updateService.dart';
import 'package:jessie_wish/common/service/userService.dart';
import 'package:jessie_wish/common/service/voucherService.dart';
import 'package:jessie_wish/common/service/wishService.dart';
import 'package:jessie_wish/common/service/foodService.dart';
import 'package:jessie_wish/common/service/annivService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:jessie_wish/common/service/oneWord.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;
  bool logined = false;
  bool canEnter = false;
  var _oneWord = "";
  var _wordAuthor = "";
  double _downloadProgress = 0.0;
  dynamic _downloadState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<LamourState> store = StoreProvider.of(context);
    _checkUpdate();
    OneWordService.getOneWord();
    NetworkSvc.getNetwork().then((res) async {
      logined = res;
      // Get user infomation
      if (logined == true) {
        canEnter = await UserSvc.readUser(store);
        WishSvc.readWish(store);
        VoucherSvc.readVoucher(store);
        AnnivSvc.readAnniv(store);
        FoodSvc.readFood(store);
      }
    });
  }

  void _checkUpdate() async {
    var res = await UpdateSvc.getLatestVersion();
    if (res != null) {
      var permission = await checkPermission();
      if (permission) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: new Text("Update Available"),
              content: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  res['content'].replaceAll('\\n', "\n"),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(LamourColors.subTextColor),
                  ),
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                CupertinoDialogAction(
                  onPressed: () {
                    _updateWorker(res);
                  },
                  child: Text("Update now"),
                ),
              ],
            );
          },
        );
      } else {
        _checkUpdate();
      }
    }
  }

  void _updateWorker(info) async {
    Navigator.pop(context);
    installApk(info['download'], info['version']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            _downloadState = state;
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              elevation: 5.0,
              title: Text("Downloading"),
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      CircularProgressIndicator(
                        value: _downloadProgress,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Text(
                        (_downloadProgress * 100).toStringAsFixed(0) + "%",
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<Null> installApk(String url, String version) async {
    File _apkFile = await downloadAndroid(url, version);
    String _apkFilePath = _apkFile.path;

    if (_apkFilePath.isEmpty) {
      return;
    }

    InstallPlugin.installApk(_apkFilePath, "com.vampuck.jessie_wish")
        .then((result) {})
        .catchError((error) {});
  }

  Future<File> downloadAndroid(String url, String version) async {
    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    File file = new File('$storagePath/lamourv${version}.apk');

    if (!file.existsSync()) {
      file.createSync();
    }

    try {
      Response response =
          await Dio().get(url, onReceiveProgress: (num received, num total) {
        showDownloadProgress(received, total);
      },
              options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
              ));
      file.writeAsBytesSync(response.data);
      return file;
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(num received, num total) {
    if (total != -1) {
      double _progress =
          double.parse('${(received / total).toStringAsFixed(2)}');
      if (_downloadState != null) {
        _downloadState(() {
          _downloadProgress = _progress;
        });
      }
    }
  }

  dynamic readWord() async {
    if (_oneWord.length != 0) {
      return _oneWord;
    }
    String oneWord = await LocalStorage.get(Config.ONE_WORD);
    _oneWord = oneWord == null || oneWord.length == 0
        ? '如果你爱上了某个星球的一朵花。那么，只要在夜晚仰望星空，就会觉得漫天的繁星就像一朵朵盛开的花。'
        : oneWord;
    return _oneWord;
  }

  dynamic readAuthor() async {
    if (_wordAuthor.length != 0) {
      return _wordAuthor;
    }
    String wordAuthor = await LocalStorage.get(Config.WORD_AUTHOR);
    _wordAuthor =
        wordAuthor == null || wordAuthor.length == 0 ? '小王子' : wordAuthor;
    return _wordAuthor;
  }

  void _goToNext() {
    if (logined == true && canEnter == true) {
      NavigatorUtils.goHome(context);
    } else {
      NavigatorUtils.goLogin(context);
    }
  }

  Future<bool> checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      if (statuses[Permission.storage] == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<LamourState>(
      builder: (context, store) {
        return new Scaffold(
          body: Container(
            color: Color(LamourColors.primaryValue),
            child: new Center(
              child: SingleChildScrollView(
                child: new Card(
                  elevation: 0,
                  color: Color(LamourColors.primaryValue),
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: new Column(
                    children: <Widget>[
                      new Image(
                          image: new AssetImage(LamourICons.DEFAULT_USER_ICON),
                          width: 150.0,
                          height: 150.0),
                      new Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      new FutureBuilder(
                        future: readWord(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(LamourColors.primaryDarkValue),
                                fontSize: 20,
                                decoration: TextDecoration.none,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      new Align(
                        alignment: FractionalOffset(1, 1),
                        child: new FutureBuilder(
                          future: readAuthor(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data != null) {
                              return Text(
                                "——" + snapshot.data,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(LamourColors.primaryDarkValue),
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _goToNext,
            elevation: 0,
            child: Icon(
              LamourICons.NEXT,
              size: 60,
              color: Color(LamourColors.textWhite),
            ),
          ),
        );
      },
    );
  }
}
