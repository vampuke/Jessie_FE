import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jessie_wish/common/model/restaurant_obj.dart';
import 'package:jessie_wish/common/style/style.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDetail(this.restaurant) : super();

  Widget _separate() {
    return Container(
      margin: EdgeInsets.all(2.0),
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

  Widget _renderDish(Dishes dish) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
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
    );
  }

  List<Widget> _dishesList() {
    List<Widget> dishList = [];
    restaurant.dishes.forEach((dish) {
      dishList.add(_separate());
      dishList.add(_renderDish(dish));
    });
    dishList.add(_separate());
    return dishList;
  }

  @override
  Widget build(BuildContext context) {
    Widget rating = RatingBarIndicator(
      rating: restaurant.rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
      unratedColor: Color(LamourColors.gray),
    );

    Widget title = Column(
      children: <Widget>[
        Text(
          restaurant.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
        ),
        Text(
          restaurant.type,
          style: TextStyle(
            fontSize: 12,
            color: Color(
              LamourColors.deleteRed,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
        ),
        Text(
          restaurant.note,
          style: TextStyle(
            fontSize: 10,
            color: Color(
              LamourColors.subTextColor,
            ),
          ),
        ),
      ],
    );

    Widget dishes = Column(
      children: _dishesList(),
    );

    return Container(
      height: 500,
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                children: <Widget>[
                  title,
                  rating,
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(
                      color: Color(LamourColors.deleteRed),
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14),
                  ),
                  dishes
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
