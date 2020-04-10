import 'dart:convert';

import 'package:jessie_wish/common/model/user.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/service/svcResult.dart';
import 'package:jessie_wish/common/redux/userRedux.dart';

class UserSvc {
  static login(userName, password, store) async {
    await LocalStorage.save(Config.USER_NAME_KEY, userName);

    Map requestParams = {"user_name": userName, "password": password};

    var res = await HttpManager.netFetch(
        Address.userLogin(), requestParams, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        Fluttertoast.showToast(msg: "Success");
        User user = User.fromJson(res.data);
        await LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        var resultData = new DataResult(user, true);
        store.dispatch(new UpdateUserAction(resultData.data));
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return null;
      }
    } else {
      return null;
    }
  }

  static readUser(store) async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      var userData = new DataResult(user, true);
      store.dispatch(new UpdateUserAction(userData.data));
      return true;
    } else {
      return false;
    }
  }
}
