import 'package:jessie_wish/common/model/food_list.dart';
import 'package:redux/redux.dart';


final foodReducer = combineReducers<FoodList>([
  TypedReducer<FoodList, UpdateFoodListAction>(_updateLoaded),
]);


FoodList _updateLoaded(FoodList foodList, action) {
  foodList = action.foodList;
  return foodList;
}

class UpdateFoodListAction {
  final FoodList foodList;
  UpdateFoodListAction(this.foodList);
}
