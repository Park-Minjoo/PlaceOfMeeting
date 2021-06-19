import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../my_account.dart';

class IntroduceEditPage extends StatefulWidget {
  final int id;
  final String comment;
  IntroduceEditPage({Key key, @required this.id, @required this.comment}) : super(key:key);
  @override
  State<StatefulWidget> createState() {
    return _IntroduceEditPageState();
  }
}

class _IntroduceEditPageState extends State<IntroduceEditPage> {
  String my_comment;
  TextEditingController textEditingController;

  Future db_save_introduction (String comment, int id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    await conn.query('UPDATE person_info SET memo = ? WHERE id = ?', [comment, id]);
    conn.close();
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.comment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction Edit'),
        backgroundColor: Colors.green,
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
////              Navigator.push();
//            },
//            child: Text("Save", style: TextStyle(fontSize: 18)),
//          )
//        ],
      ),

      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        height:300,
        child: TextFormField(
          maxLines: 10,
          controller: textEditingController,
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          autofocus: false,
          onChanged: (text) {
            my_comment = text;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
            await db_save_introduction(my_comment, widget.id);
            Navigator.pop(context);
          },
          label: Text("Save", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
      ),
    );
  }
}