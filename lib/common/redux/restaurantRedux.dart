import 'package:jessie_wish/common/model/restaurant_obj.dart';
import 'package:redux/redux.dart';

final restaurantReducer = combineReducers<RestaurantObj>([
  TypedReducer<RestaurantObj, UpdateRestaurantObjAction>(_updateLoaded),
]);

RestaurantObj _updateLoaded(RestaurantObj restaurantObj, action) {
  restaurantObj = action.restaurantObj;
  return restaurantObj;
}

class UpdateRestaurantObjAction {
  final RestaurantObj restaurantObj;
  UpdateRestaurantObjAction(this.restaurantObj);
}
