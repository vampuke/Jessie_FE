import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/voucherService.dart';
import 'package:jessie_wish/common/style/style.dart';
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
  int _duration = 1;

  int _quantity = 1;

  double _sliderValue = 1.0;

  String _gender = "She";

  String _newVoucher = "";

  final TextEditingController voucherController = new TextEditingController();

  final TextEditingController quantityController = new TextEditingController();

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
      // pullDownRefreshWidgetControl.dataList =
      //     _getStore().state.voucherList?.voucher ??= [];
      Store store = _getStore();
      if (store.state.voucherList != null &&
          store.state.voucherList.voucher != null) {
        int userId = _gender == "She" ? 2 : 1;
        pullDownRefreshWidgetControl.dataList = store.state.voucherList.voucher
            .where((Voucher voucher) => (voucher.userId == userId))
            .toList();
        print(pullDownRefreshWidgetControl.dataList);
      } else {
        pullDownRefreshWidgetControl.dataList = [];
      }
    });
  }

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  void _redeemVoucher(Voucher voucher) {
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
  }

  void _addVoucherWorker() async {
    int userId = _gender == "She" ? 2 : 1;
    CommonUtils.showLoadingDialog(context);
    VoucherSvc.addNewVoucher(
            _getStore(), _newVoucher, userId, _duration, _quantity)
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
  }

  _redeemDialog(Voucher voucher) {
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
                _redeemVoucher(voucher);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  _renderEventItem(Voucher voucher) {
    VoucherViewModel eventViewModel = VoucherViewModel.fromVoucherMap(voucher);
    return new VoucherItem(eventViewModel, onPressed: () {
      User.User _currentUser = _getStore().state.userInfo;
      if (_currentUser.role == 1) {
        _redeemDialog(voucher);
      } else {
        Fluttertoast.showToast(msg: "Permission denied");
      }
    });
  }

  void _addVoucher() {
    int userId = _gender == "She" ? 2 : 1;
    if (_getStore().state.userInfo.userId == userId &&
        _getStore().state.userInfo.role != 1) {
      Fluttertoast.showToast(msg: "Permission denied");
      return;
    }
    _newVoucher = "";
    voucherController.value = new TextEditingValue(text: "");
    quantityController.value = new TextEditingValue(text: '1');
    _sliderValue = 1.0;
    _duration = 1;
    _quantity = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return CupertinoAlertDialog(
              title: new Text("Add new voucher"),
              content: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(_sliderValue == 0.0
                                ? "Infinite"
                                : _sliderValue.toStringAsFixed(0) + " Month"),
                          ),
                          CupertinoSlider(
                            value: _sliderValue,
                            max: 3.0,
                            min: 0.0,
                            divisions: 3,
                            onChanged: (value) {
                              state(() {
                                _sliderValue = value;
                              });
                              _duration =
                                  int.parse(_sliderValue.toStringAsFixed(0));
                              print(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: Text(
                              "Name: ",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: new CupertinoTextField(
                              decoration:
                                  LamourConstant.defaultRoundedBorderDecoration,
                              controller: voucherController,
                              onChanged: (String value) {
                                _newVoucher = value;
                              },
                              placeholder: "Reason(optional)",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: Text(
                              "Quantity: ",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: new CupertinoTextField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  LamourConstant.defaultRoundedBorderDecoration,
                              controller: quantityController,
                              onChanged: (value) {
                                _quantity = int.parse(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                CupertinoDialogAction(
                  onPressed: _addVoucherWorker,
                  child: Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new StoreBuilder<LamourState>(
      builder: (context, store) {
        return new Scaffold(
          // backgroundColor: Color(LamourColors.lightGray),
          appBar: new AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: CupertinoSlidingSegmentedControl(
              backgroundColor: Color(LamourColors.primaryValue),
              thumbColor: Colors.white,
              groupValue: _gender,
              onValueChanged: (value) {
                setState(() {
                  _gender = value;
                  getVoucherList();
                });
              },
              children: {
                "She": Text("She"),
                "He": Text("He"),
              },
            ),
            actions: <Widget>[
              new IconButton(
                onPressed: _addVoucher,
                icon: new Icon(
                  Icons.add,
                  size: 30.0,
                ),
              ),
            ],
          ),
          body: PullDownRefreshWidget(
            pullDownRefreshWidgetControl,
            (BuildContext context, int index) =>
                _renderEventItem(pullDownRefreshWidgetControl.dataList[index]),
            handleRefresh,
            onLoadMore,
            refreshKey: refreshIndicatorKey,
          ),
        );
      },
    );
  }
}
