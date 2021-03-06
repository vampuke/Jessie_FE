import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/model/flower.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';

class FlowerSvc {
  static getFlower() async {
    var res = await HttpManager.netFetch(Address.flower(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        Flower flower = Flower.fromJson(res.data);
        return flower;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      return false;
    }
  }

  static updateFlower(String reason, int quantity) async {
    Map requestParams = {"reason": reason, "quantity": quantity};
    var res = await HttpManager.netFetch(
        Address.flower(), requestParams, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (res.data["code"] == 200) {
        Fluttertoast.showToast(
            msg: quantity > 0
                ? "Thank you for your generous gift!!"
                : "花花又少了  哭哭");
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

  static revertFlower(int logId, int quantity) async {
    Map requestParams = {"id": logId, "quantity": quantity};
    var res = await HttpManager.netFetch(
        Address.flower(), requestParams, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (res.data["code"] == 200) {
        Fluttertoast.showToast(msg: "Successful");
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
