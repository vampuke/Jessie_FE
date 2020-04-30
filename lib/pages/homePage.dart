import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/globalEvent.dart';
import 'package:jessie_wish/common/utils/naviManager.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';
import 'package:jessie_wish/pages/annivPage.dart';
import 'package:jessie_wish/pages/toolsPage.dart';
import 'package:jessie_wish/pages/voucherPage.dart';
import 'package:jessie_wish/pages/wishPage.dart';

class HomePage extends StatefulWidget {
  static final String sName = "home";
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime lastPopTime;

  int _currentIndex = 0;

  NaviManager _naviManager = NaviManager.instance;

  _renderTab(icon, text) {
    return new BottomNavigationBarItem(icon: Icon(icon), title: Text(text));
  }

  CupertinoTabController _tabController = new CupertinoTabController();

  _renderScaffold(index) {
    List scaffoldList = [
      new WishPage(),
      new VoucherPage(),
      new AnnivPage(),
      new ToolsPage()
    ];
    return scaffoldList[index];
  }

  @override
  void initState() {
    super.initState();
    eventBus.on<IndexEvent>().listen((event) {
      _naviManager.savedPage = null;
      if (event.pageIndex != 3 &&
          event.pageIndex != 4 &&
          event.pageIndex != 5) {
        setState(() {
          _tabController.index = event.pageIndex;
        });
      } else {
        switch (event.pageIndex) {
          case 3:
            NavigatorUtils.goFood(context);
            break;
          case 4:
            NavigatorUtils.goFlower(context);
            break;
          case 5:
            NavigatorUtils.goRestaurant(context);
            break;
          default:
        }
      }
    });
    if (_naviManager.savedPage != null) {
      switch (_naviManager.savedPage) {
        case "wish":
          setState(() {
            _tabController.index = 0;
          });
          break;
        case "voucher":
          setState(() {
            _tabController.index = 1;
          });
          break;
        case "anniv":
          setState(() {
            _tabController.index = 2;
          });
          break;
        case "food":
          Future.delayed(Duration(milliseconds: 300), () {
            NavigatorUtils.goFood(context);
          });
          break;
        case "flower":
          Future.delayed(Duration(milliseconds: 300), () {
            NavigatorUtils.goFlower(context);
          });
          break;
        case "restaurant":
          Future.delayed(Duration(milliseconds: 300), () {
            NavigatorUtils.goRestaurant(context);
          });
          break;
        default:
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> tabs = [
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
          Fluttertoast.showToast(
              msg: "Click again to exit",
              backgroundColor: Colors.black,
              textColor: Colors.white);
        } else {
          lastPopTime = DateTime.now();
          // 退出app
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBar: new CupertinoTabBar(
          activeColor: Color(0xFFEC407A),
          inactiveColor: Color(0x4C000000),
          backgroundColor: Color(0xFFF8F8F8),
          items: tabs,
          currentIndex: _currentIndex,
        ),
        tabBuilder: (BuildContext context, int index) {
          return _renderScaffold(index);
        },
      ),
    );
  }
}
