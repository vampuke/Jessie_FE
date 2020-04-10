import 'package:flutter/material.dart';
import 'package:jessie_wish/common/model/wish_list.dart';
import 'package:jessie_wish/common/model/voucher_list.dart';
import 'package:jessie_wish/common/model/food_list.dart';
import 'package:jessie_wish/common/model/anniv_list.dart';
import 'package:jessie_wish/common/redux/themeRedux.dart';
import 'package:jessie_wish/common/redux/userRedux.dart';
import 'package:jessie_wish/common/model/user.dart' as User;
import 'package:jessie_wish/common/redux/voucherRedux.dart';
import 'package:jessie_wish/common/redux/wishRedux.dart';
import 'package:jessie_wish/common/redux/foodRedux.dart';
import 'package:jessie_wish/common/redux/annivRedux.dart';

class LamourState {

  User.User userInfo;

  WishList wishList;

  VoucherList voucherList;

  FoodList foodList;

  AnnivList annivList;

  ThemeData themeData;

  LamourState({this.userInfo, this.themeData, this.wishList, this.foodList, this.annivList, this.voucherList});
  
}

LamourState appReducer(LamourState state, action) {
  return LamourState(
    
    userInfo: userReducer(state.userInfo, action),

    themeData: themeDataReducer(state.themeData, action),

    voucherList: voucherReducer(state.voucherList, action),

    wishList: wishReducer(state.wishList, action),

    foodList: foodReducer(state.foodList, action),

    annivList: annivReducer(state.annivList, action),

  );
}
