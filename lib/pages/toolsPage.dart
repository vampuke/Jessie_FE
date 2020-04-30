import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/userService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';
import 'package:redux/redux.dart';

class ToolsPage extends StatefulWidget {
  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> with WidgetsBindingObserver {
  final List<String> entries = <String>["Food", "Flower", "Restaurant", "Msg"];

  final List<String> icons = <String>[
    LamourICons.FOOD_PNG,
    LamourICons.FLOWER_PNG,
    LamourICons.RESTAURANT_PNG,
    LamourICons.RESTAURANT_PNG
  ];

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

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  void _navigateToPage(entry) {
    switch (entry) {
      case "Food":
        NavigatorUtils.goFood(context);
        break;
      case "Flower":
        NavigatorUtils.goFlower(context);
        break;
      case "Restaurant":
        NavigatorUtils.goRestaurant(context);
        break;
      case 'Msg':
        NavigatorUtils.goMsg(context);
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
    if (entries[index] == "Msg" && _getStore().state.userInfo.userId == 2) {
      return Container();
    }
    return InkWell(
      onTap: () {
        _navigateToPage(entries[index]);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image(
                image: new AssetImage(icons[index]),
                width: 40,
                height: 40,
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
    return CupertinoPageScaffold(
      child: Scaffold(
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
      ),
    );
  }
}
