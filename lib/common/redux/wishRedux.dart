import 'package:jessie_wish/common/model/wish_list.dart';
import 'package:redux/redux.dart';

final wishReducer = combineReducers<WishList>([
  TypedReducer<WishList, UpdateWishListAction>(_updateLoaded),
]);

WishList _updateLoaded(WishList wishList, action) {
  wishList = action.wishList;
  return wishList;
}

class UpdateWishListAction {
  final WishList wishList;
  UpdateWishListAction(this.wishList);
}
