import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:jessie_wish/common/service/svcResult.dart';
import 'package:jessie_wish/common/model/anniv_list.dart';
import 'package:jessie_wish/common/redux/annivRedux.dart';

class AnnivSvc {
  static getAnnivList(store) async {
    var res = await HttpManager.netFetch(Address.anniv(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        AnnivList annivList = AnnivList.fromJson(res.data);
        await LocalStorage.save(
            Config.ANNIV_LIST, json.encode(annivList.toJson()));
        var resultData = new DataResult(annivList, true);
        store.dispatch(new UpdateAnnivListAction(resultData.data));
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      return false;
    }
  }

  static addAnniv(store, String title, int date) async {
    Map requestParams = {"title": title, "datetime": date};
    var res = await HttpManager.netFetch(
        Address.anniv(), requestParams, null, new Options(method: "post"));
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

  static readAnniv(store) async {
    var annivListText = await LocalStorage.get(Config.ANNIV_LIST);
    if (annivListText != null) {
      var annivListMap = json.decode(annivListText);
      AnnivList annivList = AnnivList.fromJson(annivListMap);
      var annivListData = new DataResult(annivList, true);
      store.dispatch(new UpdateAnnivListAction(annivListData.data));
      return true;
    } else {
      store.dispatch(new UpdateAnnivListAction(new AnnivList([])));
      return false;
    }
  }
}
