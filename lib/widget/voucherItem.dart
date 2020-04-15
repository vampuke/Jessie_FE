import 'package:flutter/material.dart';
import 'package:jessie_wish/common/model/voucher_list.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/widget/shapeBorder.dart';

class VoucherItem extends StatelessWidget {
  final VoucherViewModel voucherViewModel;

  final VoidCallback onPressed;

  VoucherItem(this.voucherViewModel, {this.onPressed}) : super();

  TextStyle _dateStyle = TextStyle(color: Colors.white, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        color: Colors.orangeAccent,
        elevation: 2,
        shape: CouponShapeBorder(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          height: 100,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          textBaseline: TextBaseline.ideographic,
                          children: <Widget>[
                            Container(
                              // height: 40,
                              child: Text(
                                voucherViewModel.voucherName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 170,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text(
                                "Issue date:  ",
                                style: _dateStyle,
                              ),
                            ),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(
                                      voucherViewModel.voucherIssue)
                                  .toLocal()
                                  .toString()
                                  .substring(2, 10),
                              style: _dateStyle,
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text(
                                "Expire date:  ",
                                style: _dateStyle,
                              ),
                            ),
                            Text(
                              voucherViewModel.voucherType == 1
                                  ? DateTime.fromMillisecondsSinceEpoch(
                                          voucherViewModel.voucherExpire)
                                      .toLocal()
                                      .toString()
                                      .substring(2, 10)
                                  : "Infinite",
                              style: _dateStyle,
                            )
                          ],
                        ),
                        voucherViewModel.voucherType == 1
                            ? Row(
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    child: Text(
                                      "Days left:  ",
                                      style: _dateStyle,
                                    ),
                                  ),
                                  Text(
                                    ((voucherViewModel.voucherExpire -
                                                    DateTime.now()
                                                        .toLocal()
                                                        .millisecondsSinceEpoch) ~/
                                                86400000)
                                            .toString() +
                                        " Days",
                                    style: _dateStyle,
                                  )
                                ],
                              )
                            : Container(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text(
                                "Quantity:  ",
                                style: _dateStyle,
                              ),
                            ),
                            Text(
                              voucherViewModel.voucherQuantity.toString(),
                              style: _dateStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Redeem",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: 80,
                    height: 80,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ); // return new Container(
    //   child: new LamourCard(
    //     child: new FlatButton(
    //       onPressed: null,
    //       child: new Padding(
    //         padding: new EdgeInsets.only(
    //             left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
    //         child: new Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             new Row(
    //               children: <Widget>[
    //                 new Expanded(
    //                   child: new Column(
    //                     children: <Widget>[
    //                       new Container(
    //                         child: new Text(
    //                           voucherViewModel.voucherName != null
    //                               ? voucherViewModel.voucherName
    //                               : "Voucher",
    //                           style: LamourConstant.largeTextBold,
    //                         ),
    //                         alignment: Alignment.centerLeft,
    //                       ),
    //                       new Container(
    //                           child: new Text(
    //                               "Expire date: " +
    //                                   DateTime.fromMillisecondsSinceEpoch(
    //                                           voucherViewModel.voucherExpire)
    //                                       .toLocal()
    //                                       .toString()
    //                                       .substring(2, 10),
    //                               style: LamourConstant.smallTextBold),
    //                           margin:
    //                               new EdgeInsets.only(top: 6.0, bottom: 2.0),
    //                           alignment: Alignment.topLeft)
    //                     ],
    //                   ),
    //                 ),
    //                 new FlatButton(
    //                   onPressed: onPressed,
    //                   child: new Text(
    //                     "Redeem",
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                       color: Color(LamourColors.actionBlue),
    //                       fontSize: 18.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class VoucherViewModel {
  String voucherName;
  int voucherUser;
  int voucherExpire;
  int voucherIssue;
  int voucherId;
  int voucherType;
  int voucherQuantity;

  VoucherViewModel.fromVoucherMap(Voucher voucher) {
    voucherName = voucher.title;
    voucherUser = voucher.user.userId;
    voucherIssue = voucher.datetimeCreate;
    voucherExpire = voucher.datetimeExpire;
    voucherId = voucher.id;
    voucherType = voucher.type;
    voucherQuantity = voucher.quantity;
  }
}
