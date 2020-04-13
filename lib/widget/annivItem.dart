import 'package:flutter/material.dart';
import 'package:jessie_wish/common/model/anniv_list.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/verticalDashLine.dart';

class AnnivItem extends StatelessWidget {
  final AnnivViewModel annivViewModel;

  final VoidCallback onPressed;

  AnnivItem(this.annivViewModel, {this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    Widget grayDot = ClipOval(
      child: Container(
        width: 7,
        height: 7,
        color: Colors.grey,
      ),
    );

    Widget dashLine = Positioned(
      left: 0,
      width: 37,
      bottom: 0,
      top: 3.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            grayDot,
            Expanded(
              child: Container(
                width: 27,
                child: VerticalDashLine(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget dateTime = Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 40.0),
          child: Text(
            DateTime.fromMillisecondsSinceEpoch(annivViewModel.annivDate)
                    .toLocal()
                    .toString()
                    .substring(2, 10) +
                "   " +
                ((DateTime.now().toLocal().millisecondsSinceEpoch -
                            annivViewModel.annivDate) ~/
                        86400000)
                    .toString() +
                " Days",
            style: LamourConstant.smallTextBold,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );

    Widget annivContent = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Color(LamourColors.happyOrange),
      ),
      margin: EdgeInsets.only(top: 5.0, right: 5.0, bottom: 30.0, left: 40.0),
      padding: EdgeInsets.all(10.0),
      child: new Text(
        annivViewModel.annivName,
        style: LamourConstant.normalTextWhite,
      ),
    );

    return new Container(
      child: Row(
        children: <Widget>[
          new Expanded(
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[dateTime, annivContent],
                ),
                dashLine,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnnivViewModel {
  String annivName;
  int annivDate;
  int annivId;

  AnnivViewModel.fromAnnivMap(Anniv anniv) {
    annivName = anniv.title;
    annivDate = anniv.datetime;
    annivId = anniv.id;
  }
}
