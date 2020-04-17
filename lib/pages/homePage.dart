import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/pages/annivPage.dart';
import 'package:jessie_wish/pages/toolsPage.dart';
import 'package:jessie_wish/pages/voucherPage.dart';
import 'package:jessie_wish/pages/wishPage.dart';
import 'package:jessie_wish/widget/tabBarWidget.dart';

class HomePage extends StatelessWidget {
  static final String sName = "home";

  DateTime lastPopTime;


  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(icon, size: 25.0),
          new Text(
            text,
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(LamourICons.WISH, "WISH"),
      _renderTab(LamourICons.VOUCHER, "VOUCHER"),
      _renderTab(LamourICons.CALENDAR, "ANNIV"),
      _renderTab(LamourICons.TOOLS, "TOOLS")
    ];
    return WillPopScope(
      onWillPop: () async {
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(msg: "Click again to exit", backgroundColor: Colors.black, textColor: Colors.white);
        } else {
          lastPopTime = DateTime.now();
          // 退出app
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: new TabBarWidget(
        type: TabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: [
          new WishPage(),
          new VoucherPage(),
          new AnnivPage(),
          new ToolsPage()
        ],
        backgroundColor: LamourColors.primarySwatch,
        indicatorColor: Color(LamourColors.white),
      ),
    );
  }
}
