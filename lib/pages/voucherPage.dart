import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/voucherService.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/widget/listState.dart';
import 'package:jessie_wish/widget/pullDownRefreshWidget.dart';
import 'package:redux/redux.dart';
import 'package:jessie_wish/common/model/voucher_list.dart';
import 'package:jessie_wish/widget/voucherItem.dart';
import 'package:jessie_wish/common/model/user.dart' as User;

class VoucherPage extends StatefulWidget {
  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage>
    with
        AutomaticKeepAliveClientMixin<VoucherPage>,
        ListState<VoucherPage>,
        WidgetsBindingObserver {
  int _index = 0;

  String _newVoucher = "";

  final TextEditingController voucherController = new TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getVoucherList();
    if (pullDownRefreshWidgetControl.dataList == null ||
        pullDownRefreshWidgetControl.dataList.length == 0) {
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
    bool _result = await VoucherSvc.getAvailableVoucher(_store);
    setState(() {
      if (_result) {
        getVoucherList();
      }
    });
    isLoading = false;
    return null;
  }

  void getVoucherList() {
    setState(() {
      pullDownRefreshWidgetControl.dataList =
          _getStore().state.voucherList?.voucher ??= [];
    });
  }

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  _renderEventItem(Voucher voucher) {
    VoucherViewModel eventViewModel = VoucherViewModel.fromVoucherMap(voucher);
    return new VoucherItem(eventViewModel, onPressed: () {
      User.User _currentUser = _getStore().state.userInfo;
      if (_currentUser.role == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: new Text("Confirm redeem?"),
              actions: <Widget>[
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                CupertinoDialogAction(
                  onPressed: () {
                    CommonUtils.showLoadingDialog(context);
                    VoucherSvc.redeemVoucher(_getStore(), voucher.id).then(
                      (res) {
                        Navigator.pop(context);
                        if (res == true) {
                          Navigator.pop(context);
                          handleRefresh();
                        }
                      },
                    );
                  },
                  child: Text("Yes"),
                ),
              ],
            );
          },
        );
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
                new IconButton(
                  onPressed: () {
                    _newVoucher = "";
                    voucherController.value = new TextEditingValue(text: "");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: new Text("Add new voucher"),
                          content: Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: new CupertinoTextField(
                              controller: voucherController,
                              onChanged: (String value) {
                                _newVoucher = value;
                              },
                              placeholder: "Reason(optional)",
                            ),
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            CupertinoDialogAction(
                              onPressed: () async {
                                CommonUtils.showLoadingDialog(context);
                                VoucherSvc.addNewVoucher(
                                        _getStore(),
                                        _newVoucher,
                                        _getStore().state.userInfo.userId)
                                    .then(
                                  (res) {
                                    Navigator.pop(context);
                                    if (res == true) {
                                      _newVoucher = "";
                                      Navigator.pop(context);
                                      handleRefresh();
                                    }
                                  },
                                );
                              },
                              child: Text("Add"),
                            ),
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
