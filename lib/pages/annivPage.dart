import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/annivService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
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

  DateTime _selectedDate = DateTime.now();

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
    return new AnnivItem(eventViewModel, onPressed: () {});
  }

  Future<void> _selectDate(state) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2017),
      lastDate: DateTime.now(),
    );
    if (date == null) return;

    state(() {
      _selectedDate = date;
    });
  }

  Future<void> _addAnniv() async {
    CommonUtils.showLoadingDialog(context);
    AnnivSvc.addAnniv(_getStore(), _newAnniv,
            _selectedDate.toLocal().millisecondsSinceEpoch)
        .then((res) {
      Navigator.pop(context);
      if (res == true) {
        _newAnniv = "";
        _selectedDate = DateTime.now();
        Navigator.pop(context);
        handleRefresh();
      }
    });
  }

  void _showAddDialog() {
    _newAnniv = "";
    _selectedDate = DateTime.now();
    annivController.value = new TextEditingValue(text: "");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return CupertinoAlertDialog(
              title: new Text("Add new anniversary"),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // InkWell(
                  //   onTap: () {
                  //     _selectDate(state);
                  //   },
                  //   child: Container(
                  //     child: Text(
                  //       DateFormat.yMMMd().format(_selectedDate),
                  //     ),
                  //     margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
                  //     padding: EdgeInsets.only(
                  //         top: 6.0, bottom: 6.0, left: 40.0, right: 40.0),
                  //     decoration: BoxDecoration(
                  //       border: new Border.all(
                  //         width: 1.0,
                  //         color: Color(LamourColors.subLightTextColor),
                  //       ),
                  //       borderRadius: new BorderRadius.all(
                  //         new Radius.circular(5.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: CupertinoButton(
                      onPressed: () {
                        _selectDate(state);
                      },
                      color: Colors.white,
                      child: Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  new CupertinoTextField(
                    controller: annivController,
                    onChanged: (String value) {
                      _newAnniv = value;
                    },
                    maxLines: 2,
                    placeholder: "Event",
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                CupertinoDialogAction(onPressed: _addAnniv, child: Text("Add")),
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
          appBar: new AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              new IconButton(
                onPressed: _showAddDialog,
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
            topPadding: 30.0,
          ),
        );
      },
    );
  }
}
