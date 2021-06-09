import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'dart:async';
import 'home_page.dart';
import 'sub_pages/home_list.dart';
import 'package:mysql_utils/mysql_utils.dart';

class ChatUsers{
  String name;
  String room_ex;
  String imageURL;
  ChatUsers({@required this.name,@required this.room_ex,@required this.imageURL});
}
/*
List<ChatUsers> getList(Results results){
  List<ChatUsers> temp = [];
  for(var row in results){
    print('host_id: ${row[0]}, room_id: ${row[1]}');
    temp.add(ChatUsers(
        name: 'name', room_ex: 'room_ex', imageURL: 'imageURL'));
  }
  return temp;
}
*/
// ignore: must_be_immutable
class ManageList extends StatefulWidget {
  final int id;
  ManageList({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManageListState();
  }
}

class Manage{
  String title;
  String description;
  double count;

  Manage(this.title, this.description, this.count);
}

class _ManageListState extends State<ManageList>{
  List<Manage> _list = [];
  int num;

  Future<int> getData(int uid) async{
    List<Manage> temp = [];
    int n_data;
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    var results = await conn.query(
        'select title, description, count '
            'from rooms where host_id = ?', [uid]);
    conn.close();

    for(var row in results) {
      print('title: ${row[0]}, desc: ${row[1]}, count: ${row[2]}');
      Manage m = new Manage(row[0], row[1], row[2]);
      temp.add((m));
   //   _list.add(temp);
    }

 //   n_data = results.length;
    print(n_data);

    num = results.length;
    _list = temp;
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 3),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    int uid = widget.id;
    getData(uid);

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
              _myList(num, _list),
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

//   body: _myList(n),

/*FutureBuilder<String>(
          future: _calculation, // a previously-obtained Future<String> or null
          builder:
      ),*/

Widget _myList(int n, List<Manage> mlist){
  if(n==0){
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 100),
          Icon(
              Icons.add_shopping_cart, size: 100,
          ),
        ],
      )
    );
  }
  else{
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 75,
          color: index % 2 == 0 ? Colors.green : Colors.green[200],
          child: ListTile(
            leading: const Icon(Icons.star, color: Colors.amberAccent),
            title: Text(
              '${mlist[index].title}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ), //{entries[index]}'),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(''
                  '${mlist[index].description}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.add),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
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


/*
  @override
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "롤", room_ex: "매일 밤 열한시", imageURL: "images/userImage1.jpeg"),
    ChatUsers(name: "오버워치", room_ex: "금요일 밤", imageURL: "images/userImage2.jpeg"),
    ChatUsers(name: "A", room_ex: "AAA", imageURL: "images/userImage3.jpeg"),
    ChatUsers(name: "B", room_ex: "BBB", imageURL: "images/userImage4.jpeg"),
    ChatUsers(name: "C", room_ex: "CCC", imageURL: "images/userImage5.jpeg"),



  Widget build(BuildContext context) {
  // final HtoMArg args = ModalRoute.of(context).settings.arguments;
  // chatUsers.add(ChatUsers(name: 'name', room_ex: 'room_ex', imageURL: 'imageURL'));
    return Scaffold (
      appBar: _buildAppBar(context),
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 20),
                  child: Text(
                    '                       My Own Rooms',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            _buildChatList(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    //var items = ChatUsers();
    return Container (
      height: 700,
      alignment: Alignment.topLeft,
      child: ListView.builder (
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



class ChatRoomList extends StatefulWidget{
  String name; // 방제목
  String room_ex; // 방 설명
  String imageUrl; //Icon icon_name; // 아이콘이나 이미지
  // String time;
  // bool isMessageRead;
  ChatRoomList({@required this.name,@required this.room_ex,@required this.imageUrl/*,@required this.time,@required this.isMessageRead*/});
  @override
  _ManageListState createState() => _ManageListState();
}

*/