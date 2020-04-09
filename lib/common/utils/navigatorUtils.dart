import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jessie_wish/pages/homePage.dart';
import 'package:jessie_wish/pages/loginPage.dart';

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
}
