import 'package:jessie_wish/common/model/anniv_list.dart';
import 'package:redux/redux.dart';


final annivReducer = combineReducers<AnnivList>([
  TypedReducer<AnnivList, UpdateAnnivListAction>(_updateLoaded),
]);


AnnivList _updateLoaded(AnnivList annivList, action) {
  annivList = action.annivList;
  return annivList;
}

class UpdateAnnivListAction {
  final AnnivList annivList;
  UpdateAnnivListAction(this.annivList);
}
