import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:jessie_wish/common/service/svcResult.dart';
import 'package:jessie_wish/common/model/food_list.dart';
import 'package:jessie_wish/common/redux/foodRedux.dart';

class FoodSvc {
  static getFoodList(store) async {
    var res = await HttpManager.netFetch(Address.food(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        FoodList foodList = FoodList.fromJson(res.data);
        await LocalStorage.save(
            Config.FOOD_LIST, json.encode(foodList.toJson()));
        var resultData = new DataResult(foodList, true);
        store.dispatch(new UpdateFoodListAction(resultData.data));
        return true;
      } else {
        Fluttertoast.showToast(msg: res.data["msg"]);
        return false;
      }
    } else {
      return false;
    }
  }

  static readFood(store) async {
    var foodListText = await LocalStorage.get(Config.FOOD_LIST);
    if (foodListText != null) {
      var foodListMap = json.decode(foodListText);
      FoodList foodList = FoodList.fromJson(foodListMap);
      var foodListData = new DataResult(foodList, true);
      store.dispatch(new UpdateFoodListAction(foodListData.data));
      return true;
    } else {
      store.dispatch(new UpdateFoodListAction(new FoodList([])));
      return false;
    }
  }
}
