import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'package:mysql1/mysql1.dart';

import '../model/product_model.dart';

class CategoryDetailPage extends StatefulWidget {
  final int category_id;
  CategoryDetailPage({Key key, @required this.category_id}) : super(key:key);

  @override
  State<StatefulWidget> createState() => new _CategoryDetailPage();
}

class _CategoryDetailPage extends State<CategoryDetailPage> {

  Map<int,String> category_title = {0: 'Sports', 1: 'Game', 2:'Music', 3:'Study', 4:'Food', 5: 'Friends', 6: 'Book' ,7:'etc'};
  IconData category_icon ;
  List<ChatUsers> chatUsers = new List<ChatUsers>();

  Future db_board_list_of_category(int category_id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    var result = await conn.query("SELECT title, count FROM rooms WHERE category IN (SELECT category_id FROM interests WHERE category_id = ?)", [category_id]);

    if (result.isNotEmpty) {
      for (var row in result) {
        chatUsers.add(new ChatUsers(name: row[0], room_ex: row[1].toInt().toString(), imageURL: "images/userImage1.jpeg"));
      }
    }

    conn.close();
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  void initState() {
    super.initState();
    db_board_list_of_category(widget.category_id);
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text(category_title[widget.category_id]),
        ),
        body: SingleChildScrollView(
//          color: const Color(0xffF4F7FA),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
            child: FutureBuilder<String>(
              future: _calculation, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
//                    ListView(
//                      children: <Widget>[
                    Column(
                      children: <Widget>[
                        _buildCategoryList(), // 리얼 카테고리 나열한 친구
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 4),
                              child: Text(
                                'Boards',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildChatList(), // 리얼 아이템 나열한 친구
                      ],
                    ),
                  ];
//                  ),
//                  ];
                } else if (snapshot.hasError) {
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
                    Padding(padding: EdgeInsets.only(top:50)),
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 40,
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...', style: TextStyle(fontSize: 25)),
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ),
      );
  }

  Widget _buildCategoryList() {
    //var items = addItems();
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.all(0),
          width: 400,
          height: 200,
          alignment: Alignment.center,
          child: Icon(
            category_icon,
            size: 200,
            color: Colors.lightGreen,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 5),
                blurRadius: 15,
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildChatList() {
    //var items = ChatUsers();
    return Container(
      height: 280,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        //physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: chatUsers.length, // 채팅방 수
        itemBuilder: (context, index) {
          //var data = items[index];
          return  ChatRoomList(
            name: chatUsers[index].name,
            room_ex: chatUsers[index].room_ex,
            imageUrl: chatUsers[index].imageURL,
          );
        },
      ),
    );
  }
}

class ChatUsers{
  String name;
  String room_ex;
  String imageURL;
  ChatUsers({@required this.name,@required this.room_ex,@required this.imageURL});
}


class ChatRoomList extends StatefulWidget{
  String name; // 방제목
  String room_ex; // 방 설명
  String imageUrl; //Icon icon_name; // 아이콘이나 이미지
  // String time;
  // bool isMessageRead;
  ChatRoomList({ this.name, this.room_ex, this.imageUrl/*,@required this.time,@required this.isMessageRead*/});
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {

  Future db_category_list() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.room_ex,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}