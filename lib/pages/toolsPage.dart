import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/navigatorUtils.dart';

class ToolsPage extends StatefulWidget {
  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final List<String> entries = <String>["Food", "Flower"];

  final List<IconData> icons = <IconData>[LamourICons.FOOD, LamourICons.FLOWER];

  final List<int> colors = <int>[LamourColors.deleteRed, 0xFF4DB6AC];

  void _navigateToPage(entry) {
    switch (entry) {
      case "Food":
        NavigatorUtils.goFood(context);
        break;
      case "Flower":
        NavigatorUtils.goFlower(context);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Tools"),
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  _navigateToPage(entries[index]);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          icons[index],
                          size: 40.0,
                          color: Color(colors[index]),
                        ),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                      Expanded(
                          child: Text(
                        entries[index],
                        style: LamourConstant.largeText,
                      )),
                      Container(
                          child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(LamourColors.actionBlue),
                      ))
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color(LamourColors.subLightTextColor),
                              width: 1.0),
                          bottom: BorderSide(
                              color: Color(LamourColors.subLightTextColor),
                              width: 1.0))),
                ));
          }),
    );
  }
}
