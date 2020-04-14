import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jessie_wish/common/model/flower.dart';
import 'package:jessie_wish/common/redux/LamourState.dart';
import 'package:jessie_wish/common/service/flowerService.dart';
import 'package:jessie_wish/common/style/style.dart';
import 'package:jessie_wish/common/utils/commonUtils.dart';
import 'package:redux/redux.dart';

class FlowerPage extends StatefulWidget {
  @override
  _FlowerPageState createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> with WidgetsBindingObserver {
  String _reason = "";
  int _quantity = 0;
  Function _addFlower;
  Function _minusFlower;
  Flower _flower;
  final TextEditingController flowerController = new TextEditingController();
  final TextEditingController quantityContorller = new TextEditingController();

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

  void _updateFlower(String type) async {
    print(type);
    int quan = _quantity;
    if (type == "minus") {
      quan = 0 - _quantity;
    }
    CommonUtils.showLoadingDialog(context);
    var res = await FlowerSvc.updateFlower(_reason, quan);
    if (res == true) {
      setState(() {
        _quantity = 0;
        _reason = "";
        _minusFlower = null;
        _addFlower = null;
        quantityContorller.value = TextEditingValue(text: "");
        flowerController.value = TextEditingValue(text: "");
      });
      _flower = await _getFlower(true);
      Navigator.pop(context);
    }
  }

  void _setValue(value) {
    setState(() {
      if (value == "") {
        _addFlower = null;
        _minusFlower = null;
      } else {
        _quantity = int.parse(value);
        if (_quantity > 0) {
          _addFlower = () {
            _updateFlower("add");
          };
          _minusFlower = () {
            _updateFlower("minus");
          };
          if (_quantity > _flower.flower) {
            _minusFlower = null;
          }
        } else {
          _addFlower = null;
        }
      }
    });
  }

  Future<Flower> _getFlower(bool refresh) async {
    if (_flower == null || refresh == true) {
      var res = await FlowerSvc.getFlower();
      if (res != false) {
        setState(() {
          print('called set state');
          _flower = res;
        });
      }
    }
    return _flower;
  }

  String _getQuantity() {
    if (_flower != null && _flower.flower != null) {
      return _flower.flower.toString();
    } else {
      return "0";
    }
  }

  Widget _renderLog() {
    if (_flower != null && _flower.flowerLog != null) {
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          itemCount: _flower.flowerLog.length,
          itemBuilder: (context, index) {
            return _logItem(context, index);
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _logItem(context, index) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Text(
          DateTime.fromMillisecondsSinceEpoch(_flower.flowerLog[index].datetime)
                  .toLocal()
                  .toString()
                  .substring(2, 10) +
              "  " +
              _flower.flowerLog[index].reason +
              "  " +
              _flower.flowerLog[index].quantity.toString(),
          style: LamourConstant.smallSubLightText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget flowerNumber = Text(
      _getQuantity(),
      style: TextStyle(fontSize: 50, color: Color(LamourColors.primaryValue)),
    );

    Widget flowerIcon = Icon(
      LamourICons.FLOWER,
      size: 40,
      color: Color(LamourColors.primaryValue),
    );

    Widget flowerQuantity = Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(LamourColors.primaryValue)),
          borderRadius: BorderRadius.circular(8.0)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[flowerIcon, flowerNumber],
        ),
      ),
    );

    Widget reasonInput = Row(
      children: <Widget>[
        Container(
          width: 90,
          child: Text(
            "Reason: ",
            style: LamourConstant.normalSubText,
          ),
        ),
        Expanded(
          child: CupertinoTextField(
            controller: flowerController,
            onChanged: (value) {
              setState(() {
                _reason = value;
              });
            },
          ),
        ),
      ],
    );

    Widget quantityInput = Row(
      children: <Widget>[
        Container(
          width: 90,
          child: Text(
            "Quantity: ",
            style: LamourConstant.normalSubText,
          ),
        ),
        Container(
          width: 80,
          child: CupertinoTextField(
            keyboardType: TextInputType.number,
            controller: quantityContorller,
            onChanged: (value) {
              _setValue(value);
            },
          ),
        )
      ],
    );

    Widget btnGroup = Row(
      children: <Widget>[
        Spacer(),
        CupertinoButton(
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
          color: Color(LamourColors.actionGreen),
          onPressed: _addFlower,
        ),
        Spacer(),
        CupertinoButton(
          child: Text(
            "Minus",
            style: TextStyle(color: Colors.white),
          ),
          color: Color(LamourColors.deleteRed),
          onPressed: _minusFlower,
        ),
        Spacer(),
      ],
    );

    Widget flowerAction = Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          reasonInput,
          new Padding(padding: new EdgeInsets.all(10.0)),
          quantityInput,
          new Padding(padding: new EdgeInsets.all(10.0)),
          btnGroup,
        ],
      ),
    );

    Widget flowerContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[flowerQuantity, flowerAction, _renderLog()],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(LamourColors.primaryValue),
        title: Text("Flower"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getFlower(false),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return flowerContent;
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
