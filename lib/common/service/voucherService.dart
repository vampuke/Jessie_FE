import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:jessie_wish/common/service/svcResult.dart';
import 'package:jessie_wish/common/model/voucher_list.dart';
import 'package:jessie_wish/common/redux/voucherRedux.dart';

class VoucherSvc {
  static getAvailableVoucher(store) async {
    var res = await HttpManager.netFetch(
        Address.getAvailableVoucher(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        VoucherList voucherList = VoucherList.fromJson(res.data);
        await LocalStorage.save(
            Config.VOUDHER_LIST, json.encode(voucherList.toJson()));
        var resultData = new DataResult(voucherList, true);
        store.dispatch(new UpdateVoucherListAction(resultData.data));
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      return false;
    }
  }

  static addNewVoucher(store, String title, int userId) async {
    Map requestParams = {"title": title, "user_id": userId};
    var res = await HttpManager.netFetch(
        Address.addVoucher(), requestParams, null, new Options(method: "post"));
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

  static redeemVoucher(store, voucherId) async {
    var requestParams = {"id": voucherId, "status": 3};
    var res = await HttpManager.netFetch(
        Address.addVoucher(), requestParams, null, new Options(method: "post"));
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

  static readVoucher(store) async {
    var voucherListText = await LocalStorage.get(Config.VOUDHER_LIST);
    if (voucherListText != null) {
      var voucherListMap = json.decode(voucherListText);
      VoucherList voucherList = VoucherList.fromJson(voucherListMap);
      var voucherListData = new DataResult(voucherList, true);
      store.dispatch(new UpdateVoucherListAction(voucherListData.data));
      return true;
    } else {
      store.dispatch(new UpdateVoucherListAction(new VoucherList([])));
      return false;
    }
  }
}
