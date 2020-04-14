import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jessie_wish/common/service/userService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';

class ToolsPage extends StatefulWidget {
  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> with WidgetsBindingObserver {
  final List<String> entries = <String>["Food", "Flower"];

  final List<IconData> icons = <IconData>[LamourICons.FOOD, LamourICons.FLOWER];

  final List<int> colors = <int>[LamourColors.deleteRed, 0xFF4DB6AC];

  bool _iconStatus = false;

  Timer _timer;

  _ToolsPageState() {
    _animate();
  }

  void _animate() {
    _timer = new Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _iconStatus = !_iconStatus;
        _animate();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _navigateToPage(entry) {
    switch (entry) {
      case "Food":
        NavigatorUtils.goFood(context);
        break;
      case "Flower":
        NavigatorUtils.goFlower(context);
        break;
      default:
    }
  }

  void _logOut() async {
    CommonUtils.showLoadingDialog(context);
    UserSvc.logOut().then(
      (res) {
        Navigator.pop(context);
        if (res == true) {
          NavigatorUtils.goLogin(context);
        }
      },
    );
  }

  Widget _toolsList(context, index) {
    return InkWell(
      onTap: () {
        _navigateToPage(entries[index]);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                icons[index],
                size: 40.0,
                color: Color(colors[index]),
              ),
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
            ),
            Expanded(
              child: Text(
                entries[index],
                style: LamourConstant.largeText,
              ),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              width: _iconStatus ? 10 : 50,
              margin: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(LamourColors.actionBlue),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(LamourColors.lightGray),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Tools"),
        actions: <Widget>[
          IconButton(
            icon: Icon(LamourICons.LOG_OUT),
            onPressed: _logOut,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return _toolsList(context, index);
        },
      ),
    );
  }
}
