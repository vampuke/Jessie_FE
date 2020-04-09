import 'package:jessie_wish/common/model/voucher_list.dart';
import 'package:redux/redux.dart';


final voucherReducer = combineReducers<VoucherList>([
  TypedReducer<VoucherList, UpdateVoucherListAction>(_updateLoaded),
]);


VoucherList _updateLoaded(VoucherList voucherList, action) {
  voucherList = action.voucherList;
  return voucherList;
}

class UpdateVoucherListAction {
  final VoucherList voucherList;
  UpdateVoucherListAction(this.voucherList);
}
