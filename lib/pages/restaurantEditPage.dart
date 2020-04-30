import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jessie_wish/common/model/restaurant_obj.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/restaurantService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:jessie_wish/common/utils/globalEvent.dart';
import 'package:redux/redux.dart';

class RestaurantEditPage extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantEditPage(this.restaurant) : super();
  @override
  _RestaurantEditPageState createState() =>
      _RestaurantEditPageState(restaurant);
}

class _RestaurantEditPageState extends State<RestaurantEditPage>
    with WidgetsBindingObserver {
  final Restaurant restaurant;

  _RestaurantEditPageState(this.restaurant) : super();

  TextEditingController _restNameCtrl = new TextEditingController();
  TextEditingController _restNoteCtrl = new TextEditingController();
  TextEditingController _restTypeCtrl = new TextEditingController();
  double _restRating;

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
    super.didChangeDependencies();
    setState(() {
      _restNameCtrl.value = TextEditingValue(text: restaurant.title);
      _restTypeCtrl.value = TextEditingValue(text: restaurant.type);
      _restNoteCtrl.value = TextEditingValue(text: restaurant.note);
      _restRating = restaurant.rating;
    });
  }

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  void _deleteDish(Dishes dish) {
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
                _deleteDishWorker(dish);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteDishWorker(Dishes dish) {
    if (dish.id != null) {
      CommonUtils.showLoadingDialog(context);
      RestaurantSvc.deleteDish(_getStore(), dish.id).then(
        (res) {
          Navigator.pop(context);
          if (res == false) {
            return;
          }
        },
      );
    }
    setState(() {
      restaurant.dishes.remove(dish);
    });
    Navigator.pop(context);
  }

  void _selectType() {
    List<String> typeList = [];
    _getStore()
        .state
        .restaurantObj
        .type
        .forEach((type) => typeList.add(type.type));
    List<Widget> displayList = [];
    typeList.forEach((type) => displayList.add(Text(type)));
    String selectedType = typeList[0];
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
                            _restTypeCtrl.value =
                                TextEditingValue(text: selectedType);
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

  void _addDish() {
    _editDishDialog(new Dishes(null, '', restaurant.id, 3, ''), false);
  }

  void _editDishDialog(Dishes dish, bool edit) {
    TextEditingController dishNameCtrl = new TextEditingController();
    TextEditingController dishNoteCtrl = new TextEditingController();
    String _dishName = dish.title;
    String _dishNote = dish.note;
    double _rating = dish.rating;
    dishNameCtrl.value = new TextEditingValue(text: dish.title);
    dishNoteCtrl.value = new TextEditingValue(text: dish.note);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return CupertinoAlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoTextField(
                    decoration: LamourConstant.defaultRoundedBorderDecoration,
                    controller: dishNameCtrl,
                    onChanged: (String value) {
                      _dishName = value;
                    },
                    placeholder: "Dish name",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  CupertinoTextField(
                    decoration: LamourConstant.defaultRoundedBorderDecoration,
                    controller: dishNoteCtrl,
                    onChanged: (String value) {
                      _dishNote = value;
                    },
                    maxLines: 3,
                    placeholder: "Dish note",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  RatingBar(
                    initialRating: dish.rating,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 28,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    unratedColor: Colors.white,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating;
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Save'),
                  onPressed: () {
                    setState(() {
                      dish.title = _dishName;
                      dish.note = _dishNote;
                      dish.rating = _rating;
                      if (edit == false) {
                        restaurant.dishes.add(dish);
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Color(LamourColors.deleteRed),
                    ),
                  ),
                  onPressed: () {
                    _deleteDish(dish);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _renderDish(Dishes dish) {
    return InkWell(
      onTap: () {
        _editDishDialog(dish, true);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          border: Border.all(width: 1, color: Color(LamourColors.lightGray)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dish.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  Text(
                    dish.note,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(LamourColors.subTextColor),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              child: RatingBarIndicator(
                rating: dish.rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 14.0,
                unratedColor: Color(LamourColors.gray),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _displayDishes() {
    if (restaurant.dishes.length != 0) {
      List<Widget> dishList = [];
      restaurant.dishes.forEach((dish) {
        dishList.add(_renderDish(dish));
      });
      return dishList;
    } else {
      return [];
    }
  }

  Widget _separate() {
    return Container(
      margin: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(LamourColors.gray),
          ),
        ),
      ),
    );
  }

  Future<void> _saveRestaurant() async {
    if (_restNameCtrl.value.text == null ||
        _restNameCtrl.value.text.length == 0) {
      Fluttertoast.showToast(msg: "Please input restaurant name!");
      return;
    }
    if (_restTypeCtrl.value.text == null ||
        _restTypeCtrl.value.text.length == 0) {
      Fluttertoast.showToast(msg: "Please input restaurant type!");
      return;
    }
    setState(() {
      restaurant.title =
          _restNameCtrl.value.text != null ? _restNameCtrl.value.text : '';
      restaurant.note =
          _restNoteCtrl.value.text != null ? _restNoteCtrl.value.text : '';
      restaurant.type =
          _restTypeCtrl.value.text != null ? _restTypeCtrl.value.text : '';
    });
    var dishJson = [];
    restaurant.dishes.forEach((dish) {
      dishJson.add(dish.toJson());
    });
    dynamic restJson = restaurant.toJson();
    restJson['dishes'] = dishJson;
    CommonUtils.showLoadingDialog(context);
    RestaurantSvc.postRestaurant(_getStore(), restJson).then(
      (res) {
        Navigator.pop(context);
        if (res == true) {
          eventBus.fire(RefreshRestaurant(true));
          Navigator.pop(context);
        }
      },
    );
  }

  void _confirmBack() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Confirm"),
          content: Text('Confirm leave without save?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wordPadding = Padding(
      padding: EdgeInsets.only(left: 10),
    );

    TextStyle attrStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

    Widget addDish = Container(
      padding: EdgeInsets.all(10.0),
      color: Color(LamourColors.lightTheme),
      child: InkWell(
        onTap: _addDish,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add dish',
              style: attrStyle,
            ),
            Icon(Icons.add_circle_outline)
          ],
        ),
      ),
    );

    Widget restaurantDetail = Container(
      margin: EdgeInsets.only(top: 0, bottom: 5),
      color: Color(LamourColors.lightTheme),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              wordPadding,
              Text(
                'Name',
                style: attrStyle,
              ),
              wordPadding,
              Expanded(
                child: TextField(
                  controller: _restNameCtrl,
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              wordPadding,
            ],
          ),
          _separate(),
          Row(
            children: <Widget>[
              wordPadding,
              Text(
                'Type',
                style: attrStyle,
              ),
              wordPadding,
              InkWell(
                onTap: _selectType,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Color(LamourColors.actionBlue),
                    ),
                    color: Color(LamourColors.actionBlue),
                  ),
                  child: Text(
                    'Select',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              wordPadding,
              Expanded(
                child: TextField(
                  controller: _restTypeCtrl,
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              wordPadding,
            ],
          ),
          _separate(),
          Row(
            children: <Widget>[
              wordPadding,
              Text(
                'Note',
                style: attrStyle,
              ),
              wordPadding,
              Expanded(
                child: TextField(
                  controller: _restNoteCtrl,
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              wordPadding,
            ],
          ),
          _separate(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Rating',
                    style: attrStyle,
                  ),
                ),
                RatingBar(
                  initialRating: _restRating,
                  minRating: 0.5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 28,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  unratedColor: Colors.white,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _restRating = rating;
                      restaurant.rating = rating;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        _confirmBack();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Edit"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _confirmBack,
          ),
          actions: <Widget>[
            Center(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onTap: () {
                  _saveRestaurant();
                },
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  restaurantDetail,
                  addDish,
                  Column(
                    children: _displayDishes(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
