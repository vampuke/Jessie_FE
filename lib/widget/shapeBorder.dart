import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponShapeBorder extends ShapeBorder {
  final int holeCount; //我们打洞的个数
  final Color color; //线的颜色

  CouponShapeBorder({this.holeCount = 6, this.color = Colors.white});

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    var path = Path();
    var w = rect.width;
    var h = rect.height;
    var d = h / (1 + 2 * holeCount);

    ///这个路径就是直接吧我们的rect放上去就是我们的控件本身的path  不需要进行任何裁剪和其他操作
    // path.addRect(rect);
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));

    _formHoldLeft(path, d);
    _formHoldRight(path, w, d);
    _formHoleTop(path, rect);
    _formHoleBottom(path, rect);

    ///这个是官方文档需要我们填的  但是也需要我们的path是从getInnerPath中返回的(这个重写函数感觉写不写没多大影响！！！有兴趣的可以试试)
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  _formHoldLeft(Path path, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), -pi / 2, pi);
    }
  }

  _formHoldRight(Path path, double w, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2 + w;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), pi / 2, pi);
    }
  }

  void _formHoleBottom(Path path, Rect rect) {
    path.addArc(
        Rect.fromLTWH(rect.width - 100, rect.height - 7, 14, 14), pi, pi);
  }

  void _formHoleTop(Path path, Rect rect) {
    path.addArc(Rect.fromLTWH(rect.width - 100, -7, 14, 14), 0, pi);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
    var paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var d = rect.height / (1 + 2 * holeCount);
    //虚线
    _drawDashLine(canvas, Offset(rect.width - 93, d / 2), rect.height / 16,
        rect.height - 18, paint);
  }

  _drawDashLine(
      Canvas canvas, Offset start, double count, double length, Paint paint) {
    var step = length / count / 2;
    for (int i = 0; i < count; i++) {
      var offset = start + Offset(0, 2 * step * i);
      canvas.drawLine(offset, offset + Offset(0, step), paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
