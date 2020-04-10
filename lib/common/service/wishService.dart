import 'dart:convert';

import 'package:jessie_wish/common/redux/wishRedux.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/service/svcResult.dart';
import 'package:jessie_wish/common/model/wish_list.dart';

class WishSvc {
  static getWish(store) async {
    var res = await HttpManager.netFetch(Address.getWish(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        WishList wishList = WishList.fromJson(res.data);
        await LocalStorage.save(
            Config.WISH_LIST, json.encode(wishList.toJson()));
        var resultData = new DataResult(wishList, true);
        store.dispatch(new UpdateWishListAction(resultData.data));
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      return false;
    }
  }

  static deleteWish(store, int wishId) async {
    var res = await HttpManager.netFetch(
        Address.deleteWish() + wishId.toString(),
        null,
        null,
        new Options(method: "delete"));
    if (res != null && res.result) {
      if (res.data["code"] == 200) {
        Fluttertoast.showToast(msg: "Success");
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Network error");
      return false;
    }
  }

  static updateWishStatus(store, int wishId, status) async {
    Map requestParams = {"id": wishId, "status": status};
    var res = await HttpManager.netFetch(
        Address.getWish(), requestParams, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (res.data["code"] == 200) {
        Fluttertoast.showToast(msg: "Success");
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Network error");
      return false;
    }
  }

  static addWish(store, String wish) async {
    Map requestParams = {"title": wish};
    var res = await HttpManager.netFetch(
        Address.getWish(), requestParams, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (res.data["code"] == 200) {
        Fluttertoast.showToast(msg: "Success");
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Network error");
      return false;
    }
  }

  static readWish(store) async {
    var wishListText = await LocalStorage.get(Config.WISH_LIST);
    if (wishListText != null) {
      var wishListMap = json.decode(wishListText);
      WishList wishList = WishList.fromJson(wishListMap);
      var wishListData = new DataResult(wishList, true);
      store.dispatch(new UpdateWishListAction(wishListData.data));
      return true;
    } else {
      getWish(store);
      return false;
    }
  }
}
