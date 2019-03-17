import 'package:flutter/material.dart';
import 'package:jessie_wish/common/redux/themeRedux.dart';
import 'package:jessie_wish/common/redux/userRedux.dart';
import 'package:jessie_wish/common/model/user.dart';

/**
 * Redux全局State
 * Created by guoshuyu
 * Date: 2018-07-16
 */

///全局Redux store 的对象，保存State数据
class LamourState {

  User userInfo;

  ThemeData themeData;

  LamourState({this.userInfo, this.themeData});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
LamourState appReducer(LamourState state, action) {
  return LamourState(
    
    userInfo: UserReducer(state.userInfo, action),

    themeData: ThemeDataReducer(state.themeData, action),
  );
}
