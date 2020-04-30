import 'package:flutter/material.dart';
import 'package:jessie_wish/common/model/wish_list.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/lamourCard.dart';

class WishItem extends StatelessWidget {
  final WishViewModel wishViewModel;

  final VoidCallback onPressed;

  WishItem(this.wishViewModel, {this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    Widget checkIcon = wishViewModel.wishStatus == 3
        ? new Icon(
            Icons.check,
            color: Color(LamourColors.actionBlue),
          )
        : new Container();

    return new Container(
      child: new LamourCard(
        child: new FlatButton(
          onPressed: onPressed,
          child: new Padding(
            padding: new EdgeInsets.only(
                left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(wishViewModel.wishName,
                            style: LamourConstant.normalText)),
                    checkIcon,
                  ],
                ),
                new Container(
                    child: new Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                wishViewModel.wishDate)
                            .toLocal()
                            .toString()
                            .substring(2, 10),
                        style: LamourConstant.smallTextBold),
                    margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                    alignment: Alignment.topRight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WishViewModel {
  String wishName;
  int wishUser;
  int wishStatus;
  int wishDate;

  WishViewModel.fromWishMap(Wish wish) {
    wishName = wish.title;
    wishUser = wish.user.userId;
    wishStatus = wish.status;
    wishDate = wish.datetimeCreate;
  }
}
