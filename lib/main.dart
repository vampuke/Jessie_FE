import 'package:flutter/material.dart';
import 'package:jessie_wish/pages/homePage.dart';
import 'package:jessie_wish/pages/loginPage.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/pages/welcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = new Store<LamourState>(
    appReducer,

    initialState: new LamourState(
      themeData: CommonUtils.getThemeData(LamourColors.primarySwatch),
    ),
  );

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<LamourState>(builder: (context, store) {
        return new MaterialApp(theme: store.state.themeData, routes: {
          WelcomePage.sName: (context) {
            return WelcomePage();
          },
          LoginPage.sName: (context) {
            return new LoginPage();
          },
          HomePage.sName: (context) {
            return new HomePage();
          },
        });
      }),
    );
  }
}