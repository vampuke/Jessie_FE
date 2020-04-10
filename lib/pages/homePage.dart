import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/pages/annivPage.dart';
import 'package:jessie_wish/pages/flowerPage.dart';
import 'package:jessie_wish/pages/foodPage.dart';
import 'package:jessie_wish/pages/toolsPage.dart';
import 'package:jessie_wish/pages/voucherPage.dart';
import 'package:jessie_wish/pages/wishPage.dart';
import 'package:jessie_wish/widget/tabBarWidget.dart';

class HomePage extends StatelessWidget {
  static final String sName = "home";

  // Exit app tip
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text("Confirm to exit app?"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text("Cancel")),
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: new Text("Yes"))
              ],
            ));
  }

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
      onWillPop: () {
        return _dialogExitApp(context);
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
