import 'package:flutter/material.dart';
import 'package:jessie_wish/common/model/voucher_list.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/lamourCard.dart';

class VoucherItem extends StatelessWidget {
  final VoucherViewModel voucherViewModel;

  final VoidCallback onPressed;

  VoucherItem(this.voucherViewModel, {this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
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
                                child: new Column(
                              children: <Widget>[
                                new Container(
                                  child: new Text(
                                    voucherViewModel.voucherName != null
                                        ? voucherViewModel.voucherName
                                        : "Voucher",
                                    style: LamourConstant.largeTextBold,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                new Container(
                                    child: new Text(
                                        "Expire date: " +
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    voucherViewModel
                                                        .voucherDate)
                                                .toLocal()
                                                .toString()
                                                .substring(2, 10),
                                        style: LamourConstant.smallTextBold),
                                    margin: new EdgeInsets.only(
                                        top: 6.0, bottom: 2.0),
                                    alignment: Alignment.topLeft)
                              ],
                            )),
                            new FlatButton(
                                onPressed: onPressed,
                                child: new Text(
                                  "Redeem",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(LamourColors.actionBlue),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    )))));
  }
}

class VoucherViewModel {
  String voucherName;
  int voucherUser;
  int voucherStatus;
  int voucherDate;
  int voucherId;

  VoucherViewModel.fromVoucherMap(Voucher voucher) {
    voucherName = voucher.title;
    voucherUser = voucher.user.userId;
    voucherStatus = voucher.status;
    voucherDate = voucher.datetimeExpire;
    voucherId = voucher.id;
  }
}
