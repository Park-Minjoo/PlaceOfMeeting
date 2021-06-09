import 'package:flutter/material.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';

import '/grocerry_kit/model/product_model.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스터디'),

      ),
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _buildCategoryList(), // 리얼 카테고리 나열한 친구
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          '채팅 방',
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
            ]),
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
            Icons.menu_book_outlined,
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
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "토익 공부 같이 하실 분", room_ex: "주 3회 모여서 스터디해ㅛ", imageURL: "images/userImage1.jpeg"),
    ChatUsers(name: "면접 스터디", room_ex: "주말동안 면접 스터디 하실 분", imageURL: "images/userImage2.jpeg"),
    ChatUsers(name: "A", room_ex: "AAA", imageURL: "images/userImage3.jpeg"),
    ChatUsers(name: "B", room_ex: "BBB", imageURL: "images/userImage4.jpeg"),
    ChatUsers(name: "C", room_ex: "CCC", imageURL: "images/userImage5.jpeg"),
    ChatUsers(name: "D", room_ex: "DDD", imageURL: "images/userImage6.jpeg"),
    ChatUsers(name: "E", room_ex: "EEE", imageURL: "images/userImage7.jpeg"),
    ChatUsers(name: "F", room_ex: "FFF", imageURL: "images/userImage8.jpeg"),
  ];
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
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
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
