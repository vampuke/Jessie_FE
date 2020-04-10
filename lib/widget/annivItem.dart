import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/model/anniv_list.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/lamourCard.dart';
import 'package:redux/redux.dart';

class AnnivItem extends StatelessWidget {
  final AnnivViewModel annivViewModel;

  final VoidCallback onPressed;

  AnnivItem(this.annivViewModel, {this.onPressed}) : super();

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
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                child: new Text(
                              annivViewModel.annivName,
                              style: LamourConstant.normalTextLight,
                            ))
                          ],
                        ),
                        new Container(
                            child: new Text(
                                DateTime.fromMillisecondsSinceEpoch(
                                            annivViewModel.annivDate)
                                        .toLocal()
                                        .toString()
                                        .substring(2, 10) +
                                    "   " +
                                    ((DateTime.now()
                                                    .toLocal()
                                                    .millisecondsSinceEpoch -
                                                annivViewModel.annivDate) ~/
                                            86400000)
                                        .toString() +
                                    " Days",
                                style: LamourConstant.smallTextBold),
                            margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                            alignment: Alignment.topRight)
                      ],
                    )))));
  }
}

class AnnivViewModel {
  String annivName;
  int annivDate;
  int annivId;

  AnnivViewModel.fromAnnivMap(Anniv anniv) {
    annivName = anniv.title;
    annivDate = anniv.datetimeCreate;
    annivId = anniv.id;
  }
}
