import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jessie_wish/pages/flowerPage.dart';
import 'package:jessie_wish/pages/foodPage.dart';
import 'package:jessie_wish/pages/homePage.dart';
import 'package:jessie_wish/pages/loginPage.dart';
import 'package:jessie_wish/pages/restaurantEditPage.dart';
import 'package:jessie_wish/pages/restaurantPage.dart';
import 'package:jessie_wish/pages/sendMsg.dart';

class NavigatorUtils {
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  static goFood(BuildContext context) {
    NavigatorRouter(context, new FoodPage());
  }

  static goFlower(BuildContext context) {
    NavigatorRouter(context, new FlowerPage());
  }

  static goRestaurant(BuildContext context) {
    NavigatorRouter(context, new RestaurantPage());
  }

  static goRestaurantEdit(BuildContext context, param) {
    NavigatorRouter(context, new RestaurantEditPage(param));
  }

  static goMsg(BuildContext context) {
    NavigatorRouter(context, new SendMsgPage());
  }

  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context, new CupertinoPageRoute(builder: (context) => widget));
  }
}
