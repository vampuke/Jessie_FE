import 'package:flutter/material.dart';

class LamourInputWidget extends StatefulWidget {
  final bool obscureText;

  final String hintText;

  final IconData iconData;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  LamourInputWidget({Key key, this.hintText, this.iconData, this.onChanged, this.textStyle, this.controller, this.obscureText = false}) : super(key: key);

  @override
  _InputWidgetState createState() => new _InputWidgetState();
}

class _InputWidgetState extends State<LamourInputWidget> {

  _InputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : new Icon(widget.iconData),
      ),
    );
  }
}
