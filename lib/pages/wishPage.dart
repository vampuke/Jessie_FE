import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/model/wish_list.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/wishService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/widget/listState.dart';
import 'package:jessie_wish/widget/pullDownRefreshWidget.dart';
import 'package:jessie_wish/widget/wishItem.dart';
import 'package:jessie_wish/common/model/user.dart' as User;
import 'package:redux/redux.dart';

class WishPage extends StatefulWidget {
  @override
  _WishPageState createState() => _WishPageState();
}

class _WishPageState extends State<WishPage>
    with
        AutomaticKeepAliveClientMixin<WishPage>,
        ListState<WishPage>,
        WidgetsBindingObserver {
  int currentStatus = 1;

  bool switchType = false;

  String _newWish = "";

  final TextEditingController wishController = new TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    wishController.value = new TextEditingValue(text: "");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    updateWishList();
    if (pullDownRefreshWidgetControl.dataList.length == 0) {
      pullDownRefreshWidgetControl.needLoadMore = false;
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (pullDownRefreshWidgetControl.dataList.length != 0) {
        showRefreshLoading();
      }
    }
  }

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    Store _store = _getStore();
    bool _result = await WishSvc.getWish(_store);
    setState(() {
      if (_result) {
        updateWishList();
      }
    });
    isLoading = false;
    return null;
  }

  void updateWishList() {
    Store _store = _getStore();
    setState(() {
      pullDownRefreshWidgetControl.dataList =
          filterWish(_store.state.wishList.wish);
    });
  }

  List<Wish> filterWish(List<Wish> wishList) {
    if (wishList.length != 0) {
      return wishList.where((wish) => (wish.status == currentStatus)).toList();
    } else {
      return wishList;
    }
  }

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  _renderEventItem(Wish wish) {
    WishViewModel eventViewModel = WishViewModel.fromWishMap(wish);
    return new WishItem(eventViewModel, onPressed: () {
      User.User _currentUser = _getStore().state.userInfo;
      if (wish.userId == _currentUser.userId || _currentUser.role == 1) {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(
                      wish.status == 1 ? LamourICons.Check : Icons.refresh,
                      color: new Color(LamourColors.actionBlue),
                    ),
                    title: new Text(wish.status == 1 ? "Complete" : "Revert"),
                    onTap: () async {
                      CommonUtils.showLoadingDialog(context);
                      int status = wish.status == 1 ? 3 : 1;
                      WishSvc.updateWishStatus(_getStore(), wish.id, status)
                          .then((res) {
                        Navigator.pop(context);
                        if (res == true) {
                          Navigator.pop(context);
                          handleRefresh();
                        }
                      });
                    },
                  ),
                  new ListTile(
                    leading: new Icon(
                      LamourICons.Delete,
                      color: new Color(LamourColors.deleteRed),
                    ),
                    title: new Text("Delete"),
                    onTap: () async {
                      CommonUtils.showLoadingDialog(context);
                      WishSvc.deleteWish(_getStore(), wish.id).then((res) {
                        Navigator.pop(context);
                        if (res == true) {
                          Navigator.pop(context);
                          handleRefresh();
                        }
                      });
                    },
                  )
                ],
              );
            });
      } else {
        Fluttertoast.showToast(msg: "Permission denied");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new StoreBuilder<LamourState>(
      builder: (context, store) {
        return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: <Widget>[
                new Container(
                  child: new CupertinoSwitch(
                    value: switchType,
                    onChanged: (bool value) {
                      setState(() {
                        switchType = value;
                        currentStatus = switchType == false ? 1 : 3;
                        updateWishList();
                      });
                    },
                  ),
                ),
                new IconButton(
                  onPressed: () {
                    _newWish = "";
                    wishController.value = new TextEditingValue(text: "");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Add new wish"),
                          content: new TextField(
                            controller: wishController,
                            onChanged: (String value) {
                              _newWish = value;
                            },
                            maxLines: 5,
                            decoration: new InputDecoration(
                              hintText: "Input your wish"
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            FlatButton(
                                onPressed: () async {
                                  if (_newWish == null ||
                                      _newWish.trim().length == 0) {
                                    return;
                                  }
                                  CommonUtils.showLoadingDialog(context);
                                  WishSvc.addWish(_getStore(), _newWish)
                                      .then((res) {
                                    Navigator.pop(context);
                                    if (res == true) {
                                      _newWish = "";
                                      Navigator.pop(context);
                                      handleRefresh();
                                    }
                                  });
                                },
                                child: Text("Add")),
                          ],
                        );
                      },
                    );
                  },
                  icon: new Icon(
                    Icons.add,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            body: PullDownRefreshWidget(
              pullDownRefreshWidgetControl,
              (BuildContext context, int index) => _renderEventItem(
                  pullDownRefreshWidgetControl.dataList[index]),
              handleRefresh,
              onLoadMore,
              refreshKey: refreshIndicatorKey,
            ));
      },
    );
  }
}
