import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/model/food_list.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/foodService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:redux/redux.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with WidgetsBindingObserver {
  String _gender = "She";
  String _type = "Like";
  String _newFood = "";
  final TextEditingController foodController = new TextEditingController();
  List<Food> _foodList;
  List<Food> _filteredList;

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    _foodList = _getStore().state.foodList.food;
    _updateFoodList();
    _filterFood();
    super.didChangeDependencies();
  }

  void _filterFood() {
    setState(
      () {
        int foodType = _type == "Like" ? 1 : 2;
        int userId = _gender == "He" ? 1 : 2;
        _filteredList = _foodList
            .where((food) => (food.type == foodType && food.userId == userId))
            .toList();
      },
    );
  }

  List<Widget> _renderFood() {
    print("called render");
    List<Widget> foodList = [];
    print(_filteredList);
    if (_filteredList != null) {
      for (var food in _filteredList) {
        foodList.add(foodItem(food.foodName, food.id));
      }
    }
    foodList.add(Container());
    print(foodList);
    return foodList;
  }

  Future<void> _updateFoodList() async {
    Store store = _getStore();
    var res = await FoodSvc.getFoodList(store);
    if (res) {
      setState(
        () {
          _foodList = store.state.foodList.food;
          _filterFood();
        },
      );
    }
  }

  Future<void> _addFood() async {
    CommonUtils.showLoadingDialog(context);
    int foodType = _type == "Like" ? 1 : 2;
    int userId = _gender == "He" ? 1 : 2;
    FoodSvc.addFood(_getStore(), _newFood, foodType, userId).then(
      (res) {
        Navigator.pop(context);
        if (res == true) {
          _newFood = "";
          Navigator.pop(context);
          _updateFoodList();
        }
      },
    );
  }

  void _deleteFood(foodId) async {
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
                _deleteFoodWorker(foodId);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteFoodWorker(foodId) async {
    CommonUtils.showLoadingDialog(context);
    FoodSvc.deleteFood(_getStore(), foodId).then(
      (res) {
        Navigator.pop(context);
        if (res == true) {
          _updateFoodList();
        }
      },
    );
  }

  void _addFoodDialog() {
    _newFood = "";
    foodController.value = new TextEditingValue(text: "");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return CupertinoAlertDialog(
              title: new Text(_gender + " " + _type.toLowerCase()),
              content: Container(
                margin: EdgeInsets.only(top: 20),
                child: new CupertinoTextField(
                  decoration: LamourConstant.defaultRoundedBorderDecoration,
                  controller: foodController,
                  onChanged: (String value) {
                    _newFood = value;
                  },
                  placeholder: "Input food name",
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                CupertinoDialogAction(onPressed: _addFood, child: Text("Add")),
              ],
            );
          },
        );
      },
    );
  }

  Widget foodItem(foodName, foodId) {
    return Chip(
      backgroundColor: Color(
          _type == "Like" ? LamourColors.likeGreen : LamourColors.dislikeRed),
      label: Text(foodName),
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      deleteIcon: Icon(
        LamourICons.Delete,
        color: Colors.white,
      ),
      onDeleted: () {
        _deleteFood(foodId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget gender = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: CupertinoSlidingSegmentedControl(
              backgroundColor: Color(LamourColors.primaryValue),
              thumbColor: Colors.white,
              groupValue: _gender,
              onValueChanged: (value) {
                setState(() {
                  _gender = value;
                  _filterFood();
                });
              },
              children: {
                "She": Text("She"),
                "He": Text("He"),
              },
            ),
          ),
        )
      ],
    );

    Widget type = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: CupertinoSlidingSegmentedControl(
              backgroundColor: Color(LamourColors.primaryValue),
              thumbColor: Colors.white,
              groupValue: _type,
              onValueChanged: (value) {
                setState(() {
                  _type = value;
                  _filterFood();
                });
              },
              children: {
                "Like": Text("Like"),
                "Dislike": Text("Dislike"),
              },
            ),
          ),
        )
      ],
    );

    Widget foodDisplay = Container(
        padding: EdgeInsets.all(5.0),
        child: Wrap(
          children: _renderFood(),
          spacing: 10.0,
        ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Food"),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          new SliverPadding(
            padding: const EdgeInsets.only(bottom: 80.0),
            sliver: new SliverList(
              delegate: new SliverChildListDelegate(
                <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[gender, type, foodDisplay],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFoodDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(LamourColors.actionGreen),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
