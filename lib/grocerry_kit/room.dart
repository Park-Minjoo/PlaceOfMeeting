import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'board_pages/board_room.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';

class MyRoomList extends StatelessWidget {
  int id;
  Map<Map<String,int>, int> room_info = new Map<Map<String,int>, int>() ;

  // final Map<String, int> title_count_set = new Map<String,int>();
  final List<String> title_set = new List<String>();
  final List<int> count_set = new List<int>();
  // final List<int> selected_set = new List<int>();


  Future<int> getChat() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    var results = await conn.query(
        'SELECT title, count FROM rooms, room_people WHERE room_people.room_id = rooms.room_id AND room_people.ID = ?', [id]
    );

    if(results.isNotEmpty){
      for(var row in results){
        title_set.add(row[0]);
        count_set.add(row[1].toInt());
        // title_count_set.addAll({row[0]: row[1].toInt()}) ;
        // selected_set.add(row[2].toInt());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'My rooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: FlatButton(
                    onPressed: () async{
                      title_set.clear();
                      count_set.clear();
                     await getChat();
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
            _buildChatList(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    //var items = ChatUsers();
    return Container(
      height: 500,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        //physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: title_set.length, // 채팅방 수
        itemBuilder: (context, index){
          //var data = items[index];
          return  RoomList(
            name: title_set[index],
            room_ex: count_set[index].toString(),
            imageUrl: "",
          );
        },
      ),
    );
  }
  // List<Users> chatUsers = [
    // ChatUsers(name: "롤", room_ex: "매일 밤 열한시", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "오버워치", room_ex: "금요일 밤", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "A", room_ex: "AAA", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "B", room_ex: "BBB", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "C", room_ex: "CCC", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "D", room_ex: "CCC", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "E", room_ex: "CCC", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    // ChatUsers(name: "F", room_ex: "CCC", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
  // ];
}

class Users{
  String name;
  String room_ex;
  String imageURL;
  String id;
  Users({@required this.name,@required this.room_ex,@required this.imageURL, @required this.id});
}

class RoomList extends StatefulWidget{
  String name; // 방제목
  String room_ex; // 방 설명
  String imageUrl; //Icon icon_name; // 아이콘이나 이미지
  String id;

  // String time;
  // bool isMessageRead;
  RoomList({@required this.name,@required this.room_ex,@required this.imageUrl, @required this.id/*,@required this.time,@required this.isMessageRead*/});
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/grocerry/chatroom');
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
                  // IconButton(
                  //     icon: Icon(Icons.search, size: 30, color: Colors.lime),
                  //     onPressed:(){
                  //       // print(widget.room_id);
                  //       // print(widget.room_ex);
                  //       // Navigator.pushNamed(context, '/grocerry/board');
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => BoardPage(room_id: widget.id))
                  //       );
                  //     }
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}