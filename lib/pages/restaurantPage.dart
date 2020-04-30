import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/model/restaurant_obj.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/restaurantService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/utils/globalEvent.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';
import 'package:jessie_wish/widget/listState.dart';
import 'package:jessie_wish/widget/pullDownRefreshWidget.dart';
import 'package:jessie_wish/widget/restaurantDetial.dart';
import 'package:jessie_wish/widget/restaurantItem.dart';
import 'package:redux/redux.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with
        AutomaticKeepAliveClientMixin<RestaurantPage>,
        ListState<RestaurantPage>,
        WidgetsBindingObserver {
  RestaurantObj _restaurantObj;

  String filter = 'All';

  bool hasData = false;

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    eventBus.on<RefreshRestaurant>().listen((event) {
      if (event.refresh == true) {
        handleRefresh();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    await _getRestaurant(true);
    isLoading = false;
    return null;
  }

  void _deleteRestaurant(id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Confirm delete?"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.pop(context);
                _deleteRestaurantWorker(id);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteRestaurantWorker(id) async {
    CommonUtils.showLoadingDialog(context);
    RestaurantSvc.deleteRestaurant(_getStore(), id).then(
      (res) {
        Navigator.pop(context);
        if (res == true) {
          _getRestaurant(true);
        }
      },
    );
  }

  Widget filterItem(String type) {
    return Text(type);
  }

  _showFilter() async {
    List<String> typeList = ['All'];
    _restaurantObj.type.forEach((type) => typeList.add(type.type));
    List<Widget> displayList = [];
    typeList.forEach((type) => displayList.add(filterItem(type)));
    String selectedType = 'All';
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: CupertinoButton(
                        child: Text(
                          'Select',
                        ),
                        color: Color(LamourColors.lightGray),
                        pressedOpacity: 1,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            filter = selectedType;
                            _getRestaurant(false);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 30,
                  children: displayList,
                  backgroundColor: Color(LamourColors.lightGray),
                  onSelectedItemChanged: (index) {
                    selectedType = typeList[index];
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _renderRestaurantItem(Restaurant restaurant) {
    RestaurantViewModel restaurantViewModel =
        RestaurantViewModel.fromRestaurantMap(restaurant);
    return new RestaurantItem(
      restaurantViewModel,
      onLongPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(
                    Icons.edit,
                    color: new Color(LamourColors.actionBlue),
                  ),
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    NavigatorUtils.goRestaurantEdit(context, restaurant);
                  },
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.delete,
                    color: new Color(LamourColors.deleteRed),
                  ),
                  title: Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                    _deleteRestaurant(restaurant.id);
                  },
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.cancel,
                    // color: new Color(LamourColors.deleteRed),
                  ),
                  title: Text('Cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              content: RestaurantDetail(restaurant),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<RestaurantObj> _getRestaurant(bool refresh) async {
    List list = [];
    if (_restaurantObj == null || refresh == true) {
      var res = await RestaurantSvc.getRestaurantObj(_getStore());
      if (res != false) {
        setState(() {
          _restaurantObj = _getStore().state.restaurantObj;
          list = _filterRestaurant(_restaurantObj.restaurant);
        });
      }
    } else {
      list = _filterRestaurant(_restaurantObj.restaurant);
    }
    if (list.length != 0) {
      list.sort((left, right) => right.rating.compareTo(left.rating));
    }
    pullDownRefreshWidgetControl.dataList = list;
    setState(() {
      hasData = true;
    });
    return _restaurantObj;
  }

  List<Restaurant> _filterRestaurant(List<Restaurant> list) {
    if (filter == "All") {
      return list;
    } else if (list.length != 0) {
      return list.where((restaurant) => (restaurant.type == filter)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget restaurantContent = PullDownRefreshWidget(
      pullDownRefreshWidgetControl,
      (BuildContext context, int index) =>
          _renderRestaurantItem(pullDownRefreshWidgetControl.dataList[index]),
      handleRefresh,
      onLoadMore,
      refreshKey: refreshIndicatorKey,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(LamourColors.primaryValue),
        title: Text(
          "Restaurant",
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _showFilter();
            },
            child: Row(
              children: <Widget>[
                Center(
                  child: Text(
                    filter,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          )
        ],
      ),
      body: Container(child: restaurantContent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorUtils.goRestaurantEdit(
              context, new Restaurant(null, '', '', 3.0, '', []));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(LamourColors.actionGreen),
      ),
    );
  }
}
