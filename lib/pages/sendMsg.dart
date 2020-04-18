import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/userService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:redux/redux.dart';

class SendMsgPage extends StatefulWidget {
  @override
  _SendMsgPageState createState() => _SendMsgPageState();
}

class _SendMsgPageState extends State<SendMsgPage> with WidgetsBindingObserver {
  String _title = "";
  String _alert = "";
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController alertController = new TextEditingController();

  Store<LamourState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(LamourColors.primaryValue),
        title: Text("Flower"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: alertController,
                    onChanged: (value) {
                      setState(() {
                        _alert = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text('Send'),
                  onPressed: () {
                    UserSvc.sendMessage(_title, _alert);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
