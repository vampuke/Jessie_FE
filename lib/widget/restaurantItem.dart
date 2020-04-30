import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jessie_wish/common/model/restaurant_obj.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/lamourCard.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantViewModel restaurantViewModel;

  final VoidCallback onPressed;

  final VoidCallback onLongPressed;

  RestaurantItem(this.restaurantViewModel, {this.onPressed, this.onLongPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    Widget rating = RatingBarIndicator(
      rating: restaurantViewModel.restaurantRating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
    );

    Widget info = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            restaurantViewModel.restaurantTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            restaurantViewModel.restaurantType,
            style: TextStyle(color: Color(LamourColors.dislikeRed)),
          ),
          Text(
            restaurantViewModel.restaurantNote,
            style: TextStyle(
              color: Color(
                LamourColors.subTextColor,
              ),
              fontSize: 10,
            ),
          )
        ],
      ),
    );

    return Container(
      child: LamourCard(
        child: Container(
          padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: onPressed,
            onLongPress: onLongPressed,
            child: Row(
              children: <Widget>[
                info,
                rating,
                Text(
                  restaurantViewModel.restaurantRating.toString(),
                  style: TextStyle(
                    color: Color(LamourColors.deleteRed),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantViewModel {
  String restaurantTitle;
  int restaurantId;
  String restaurantType;
  double restaurantRating;
  String restaurantNote;

  RestaurantViewModel.fromRestaurantMap(Restaurant restaurant) {
    restaurantTitle = restaurant.title;
    restaurantId = restaurant.id;
    restaurantType = restaurant.type;
    restaurantRating = restaurant.rating;
    restaurantNote = restaurant.note;
  }
}
