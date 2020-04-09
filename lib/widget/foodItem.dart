import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/model/food_list.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/widget/lamourCard.dart';
import 'package:redux/redux.dart';

class FoodItem extends StatelessWidget {
  final FoodViewModel foodViewModel;

  final VoidCallback onPressed;

  FoodItem(this.foodViewModel, {this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    Store<LamourState> _getStore() {
      if (context == null) {
        return null;
      }
      return StoreProvider.of(context);
    }

    return new Container(
        child: new LamourCard(
            child: new FlatButton(
                onPressed: null,
                child: new Padding(
                    padding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(foodViewModel.foodName)
                        // new Row(
                        //   children: <Widget>[
                        //     new Expanded(
                        //         child: new Column(
                        //       children: <Widget>[
                        //         new Container(
                        //           child: new Text(
                        //             foodViewModel.foodName != null
                        //                 ? foodViewModel.foodName
                        //                 : "Food",
                        //             style: LamourConstant.largeTextBold,
                        //           ),
                        //           alignment: Alignment.centerLeft,
                        //         ),
                        //         new Container(
                        //             child: new Text(
                        //                 "Expire date: " +
                        //                     DateTime.fromMillisecondsSinceEpoch(
                        //                             int.parse(foodViewModel
                        //                                 .foodDate))
                        //                         .toLocal()
                        //                         .toString()
                        //                         .substring(2, 10),
                        //                 style: LamourConstant.smallTextBold),
                        //             margin: new EdgeInsets.only(
                        //                 top: 6.0, bottom: 2.0),
                        //             alignment: Alignment.topLeft)
                        //       ],
                        //     )),
                        //     new FlatButton(
                        //         onPressed: onPressed,
                        //         child: new Text(
                        //           "Redeem",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             color: Color(LamourColors.actionBlue),
                        //             fontSize: 18.0,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                      ],
                    )))));
  }
}

class FoodViewModel {
  String foodName;
  int foodUser;
  int foodId;
  int foodType;

  FoodViewModel.fromFoodMap(Food food) {
    foodName = food.foodName;
    foodUser = food.userId;
    foodId = food.id;
    foodType = food.type;
  }
}
