import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/model/food_list.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:redux/redux.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with WidgetsBindingObserver {
  String _gender = "She";
  String _type = "Like";
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
    print(_foodList);
    _filterFood();
    super.didChangeDependencies();
  }

  void _filterFood() {
    setState(() {
      int foodType = _type == "Like" ? 1 : 2;
      int userId = _gender == "He" ? 1 : 2;
      _filteredList = _foodList
          .where((food) => (food.type == foodType && food.userId == userId))
          .toList();
    });
  }

  List<Widget> _renderFood() {
    print("called render");
    List<Widget> foodList = [];
    print(_filteredList);
    if (_filteredList != null) {
      for (var food in _filteredList) {
        foodList.add(foodItem(food.foodName));
      }
    }
    foodList.add(addBtn);
    print(foodList);
    return foodList;
  }

  Widget foodItem(foodName) {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      height: 36.0,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Color(LamourColors.actionBlue)),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Text(
        foodName,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, height: 2.0),
      ),
    );
  }

  Widget addBtn = InkWell(
    child: Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      height: 36.0,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Color(LamourColors.actionBlue)),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Text(
        "Add",
        style: TextStyle(color: Color(LamourColors.actionBlue), fontSize: 14, height: 2.0),
      ),
    ),
    onTap: () {print('aaa');},
  );

  @override
  Widget build(BuildContext context) {
    Widget gender = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: CupertinoSlidingSegmentedControl(
                backgroundColor: Color(LamourColors.primaryValue),
                groupValue: _gender,
                onValueChanged: (value) {
                  setState(() {
                    _gender = value;
                    _filterFood();
                  });
                },
                children: {"She": Text("She"), "He": Text("He")}),
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
                groupValue: _type,
                onValueChanged: (value) {
                  setState(() {
                    _type = value;
                    _filterFood();
                  });
                },
                children: {"Like": Text("Like"), "Dislike": Text("Dislike")}),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[gender, type, foodDisplay],
      ),
    );
  }
}
