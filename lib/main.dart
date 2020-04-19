import 'package:flutter/material.dart';
import 'package:jessie_wish/pages/homePage.dart';
import 'package:jessie_wish/pages/loginPage.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/pages/welcomePage.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:jessie_wish/common/utils/logoutEvent.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();

  MyApp({Key key}) : super(key: key);
}

class _MyAppState extends State<MyApp> {
  final store = new Store<LamourState>(
    appReducer,
    initialState: new LamourState(
      themeData: CommonUtils.getThemeData(LamourColors.primarySwatch),
    ),
  );

  final JPush jpush = new JPush();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();


  @override
  void initState() {
    super.initState();
    initPlatformState();
    eventBus.on<LogoutEvent>().listen((event) {
      navigatorKey.currentState.pushReplacementNamed("/");
    });
  }


  Future<void> initPlatformState() async {
    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("收到提醒！！！: $message");
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("打开提醒！！！: $message");
        },
      );
    } catch (e) {
      print(e);
    }

    jpush.setup(
      appKey: "14adae6f2ab53155ff2783a8", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: false,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<LamourState>(
        builder: (context, store) {
          return new MaterialApp(
            theme: store.state.themeData,
            routes: {
              WelcomePage.sName: (context) {
                return WelcomePage();
              },
              LoginPage.sName: (context) {
                return new LoginPage();
              },
              HomePage.sName: (context) {
                return new HomePage();
              },
            },
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}
