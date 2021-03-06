import 'package:flutter/material.dart';
import 'package:jessie_wish/common/style/style.dart';

class LamourCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;

  LamourCard(
      {@required this.child,
      this.margin,
      this.color,
      this.shape,
      this.elevation = 5.0});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??= EdgeInsets.only(left: 10.0, top: 6.0, right: 10.0, bottom: 6.0);
    shape ??= new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)));
    color ??= new Color(LamourColors.cardWhite);
    return new Card(
        elevation: elevation,
        shape: shape,
        color: color,
        margin: margin,
        child: child);
  }
}
