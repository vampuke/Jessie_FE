import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/model/restaurant_obj.dart';
import 'package:jessie_wish/common/redux/restaurantRedux.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:jessie_wish/common/service/svcResult.dart';

class RestaurantSvc {
  static getRestaurantObj(store) async {
    var res =
        await HttpManager.netFetch(Address.restaurant(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        RestaurantObj restaurantObj = RestaurantObj.fromJson(res.data);
        var resultData = new DataResult(restaurantObj, true);
        store.dispatch(new UpdateRestaurantObjAction(resultData.data));
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      return false;
    }
  }

  static deleteRestaurant(store, int id) async {
    var res = await HttpManager.netFetch(
      Address.delRestaurant() + id.toString(),
      null,
      null,
      Options(method: "delete"),
    );
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

  static deleteDish(store, int id) async {
    var res = await HttpManager.netFetch(
      Address.delDish() + id.toString(),
      null,
      null,
      Options(method: "delete"),
    );
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

  static postRestaurant(store, param) async {
    var res = await HttpManager.netFetch(
        Address.restaurant(), param, null, Options(method: "post"));
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
}
