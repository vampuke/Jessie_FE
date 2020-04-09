import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/service/networkService.dart';
import 'package:jessie_wish/common/service/userService.dart';
import 'package:jessie_wish/common/service/voucherService.dart';
import 'package:jessie_wish/common/service/wishService.dart';
import 'package:jessie_wish/common/service/foodService.dart';
import 'package:jessie_wish/common/service/annivService.dart';
import 'package:redux/redux.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:jessie_wish/common/service/oneWord.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<LamourState> store = StoreProvider.of(context);
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

  dynamic readWord() async {
    if (_oneWord.length != 0) {
      return _oneWord;
    }
    String oneWord = await LocalStorage.get(Config.ONE_WORD);
    _oneWord = oneWord == null || oneWord.length == 0 ? '如果你爱上了某个星球的一朵花。那么，只要在夜晚仰望星空，就会觉得漫天的繁星就像一朵朵盛开的花。' : oneWord;
    return _oneWord;
  }

  dynamic readAuthor() async {
    if (_wordAuthor.length != 0) {
      return _wordAuthor;
    }
    String wordAuthor = await LocalStorage.get(Config.WORD_AUTHOR);
    _wordAuthor = wordAuthor == null || wordAuthor.length == 0 ? '小王子' : wordAuthor;
    return _wordAuthor;
  }

  void _goToNext() {
    if (logined == true && canEnter == true) {
      NavigatorUtils.goHome(context);
    } else {
      NavigatorUtils.goLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_oneWord);
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
                            print("read");
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
            tooltip: 'Increment',
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
