import 'package:flutter/material.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';

class Arg {
  final int uid;
  Arg(this.uid);
}

// ignore: must_be_immutable
class ManageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
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
                    'My Chatrooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: FlatButton(
                    onPressed: () {},
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
      height: 700,
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
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "롤", room_ex: "매일 밤 열한시", imageURL: "images/userImage1.jpeg"),
    ChatUsers(name: "오버워치", room_ex: "금요일 밤", imageURL: "images/userImage2.jpeg"),
    ChatUsers(name: "A", room_ex: "AAA", imageURL: "images/userImage3.jpeg"),
    ChatUsers(name: "B", room_ex: "BBB", imageURL: "images/userImage4.jpeg"),
    ChatUsers(name: "C", room_ex: "CCC", imageURL: "images/userImage5.jpeg"),
  ];
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
            Navigator.pushNamed(context, '/');
          }
    ),
    title: Text(
      'Place of Meeting',
      style: TextStyle(color: Colors.white),
      ),
    );
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
  ChatRoomList({@required this.name,@required this.room_ex,@required this.imageUrl/*,@required this.time,@required this.isMessageRead*/});
  @override
  _ManageOneState createState() => _ManageOneState();
}

class _ManageOneState extends State<ChatRoomList> {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}