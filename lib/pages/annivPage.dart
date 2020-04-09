import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/annivService.dart';
import 'package:jessie_wish/widget/listState.dart';
import 'package:jessie_wish/widget/pullDownRefreshWidget.dart';
import 'package:redux/redux.dart';
import 'package:jessie_wish/common/model/anniv_list.dart';
import 'package:jessie_wish/widget/annivItem.dart';

class AnnivPage extends StatefulWidget {
  @override
  _AnnivPageState createState() => _AnnivPageState();
}

class _AnnivPageState extends State<AnnivPage>
    with
        AutomaticKeepAliveClientMixin<AnnivPage>,
        ListState<AnnivPage>,
        WidgetsBindingObserver {
  int _index = 0;

  String _newAnniv = "";

  final TextEditingController annivController = new TextEditingController();

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
    getAnnivList();
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
    bool _result = await AnnivSvc.getAnnivList(_store);
    setState(() {
      if (_result) {
        getAnnivList();
      }
    });
    isLoading = false;
    return null;
  }

  void getAnnivList() {
    setState(() {
      pullDownRefreshWidgetControl.dataList =
          _getStore().state.annivList.anniv ??= [];
      print(pullDownRefreshWidgetControl.dataList);
    });
  }

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  _renderEventItem(Anniv voucher) {
    AnnivViewModel eventViewModel = AnnivViewModel.fromAnnivMap(voucher);
    return new AnnivItem(eventViewModel, onPressed: () {
      print('Clicked');
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
                    _newAnniv = "";
                    annivController.value = new TextEditingValue(text: "");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Reason(optional)"),
                          content: new TextField(
                            controller: annivController,
                            onChanged: (String value) {
                              _newAnniv = value;
                            },
                            decoration: new InputDecoration(
                                hintText: "Input your wish"),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            FlatButton(
                                onPressed: () async {
                                  // CommonUtils.showLoadingDialog(context);
                                  // AnnivSvc.addNewVoucher(
                                  //         _getStore(),
                                  //         _newanniv,
                                  //         _getStore().state.userInfo.userId)
                                  //     .then((res) {
                                  //   Navigator.pop(context);
                                  //   if (res == true) {
                                  //     _newVoucher = "";
                                  //     Navigator.pop(context);
                                  //     handleRefresh();
                                  //   }
                                  // });
                                  // print('clicked');
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
