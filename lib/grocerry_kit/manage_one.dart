import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'dart:async';
import 'home_page.dart';
import 'sub_pages/home_list.dart';
import 'package:mysql_utils/mysql_utils.dart';

class ManageOne extends StatefulWidget {
  final int id;
  ManageOne({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManageOneState();
  }
}

final Future<String> _calculation = Future<String>.delayed(
  const Duration(seconds: 3),
      () => 'Data Loaded',
);

class _ManageOneState extends State<ManageOne>{

  @override
  Widget build(BuildContext context) {
    int uid = widget.id;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
            child: FutureBuilder<String>(
              future: _calculation,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                List<Widget> children;
                if(snapshot.hasData){
                  children = <Widget>[
                    SizedBox(height: 30),
                    Text(
                      'Managing',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text('zz'),
                  ];
                }else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    Padding(padding: EdgeInsets.only(top:300)),
                    SizedBox(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                      width: 40,
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          )
      )
    );
  }
}

Widget _buildAppBar(context) {
  return AppBar(
    centerTitle: true,
    brightness: Brightness.dark,
    elevation: 0,
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed:(){
          Navigator.pop(context);
        }
    ),
    title: Text(
      'Place of Meeting',
      style: TextStyle(color: Colors.white),
    ),
  );
}

