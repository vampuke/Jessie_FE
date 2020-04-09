import 'package:jessie_wish/common/model/user.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}
