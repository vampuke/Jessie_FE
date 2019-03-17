import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/inputWidget.dart';
import 'package:jessie_wish/widget/flexButton.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';

class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _userName = "";
  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

    _LoginPageState() : super();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  @override
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<LamourState>(builder: (context, store) {
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: new Container(
            color: Theme.of(context).primaryColor,
            child: new Center(
              //防止overFlow的现象
              child: SafeArea(
                child: SingleChildScrollView(
                  child: new Card(
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: Color(LamourColors.cardWhite),
                    margin: const EdgeInsets.only(left:30.0, right: 30.0),
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Image(image: new AssetImage(GSYICons.DEFAULT_USER_ICON), width: 90.0, height: 90.0),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new InputWidget(
                            hintText: "Input name",
                            // iconData: GSYICons.LOGIN_USER,
                            onChanged: (String value) {
                              _userName = value;
                            },
                            controller: userController,
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new InputWidget(
                            hintText: "Input password",
                            // iconData: GSYICons.LOGIN_PW,
                            obscureText: true,
                            onChanged: (String value) {
                              _password = value;
                            },
                            controller: pwController,
                          ),
                          new Padding(padding: new EdgeInsets.all(30.0)),
                          new FlexButton(
                            text: 'Login',
                            color: Theme.of(context).primaryColor,
                            textColor: Color(LamourColors.textWhite),
                            onPress: () {
                              if (_userName == null || _userName.length == 0) {
                                return;
                              }
                              if (_password == null || _password.length == 0) {
                                return;
                              }
                              CommonUtils.showLoadingDialog(context);
                              // UserDao.login(_userName.trim(), _password.trim(), store).then((res) {
                              //   Navigator.pop(context);
                              //   if (res != null && res.result) {
                              //     new Future.delayed(const Duration(seconds: 1), () {
                              //       // NavigatorUtils.goHome(context);
                              //       return true;
                              //     });
                              //   }
                              // });
                              print('login');
                            },
                          ),
                          new Padding(padding: new EdgeInsets.all(30.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
