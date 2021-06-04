import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../game.dart';
import '../model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';

//https://medium.com/flutter-community/building-a-chat-app-with-flutter-and-firebase-from-scratch-9eaa7f41782e
// 여기 참고해서 DB랑 연결 시 코드 변경경
class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    '전체 카테고리',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            _buildCategoryList(), // 리얼 카테고리 나열한 친구
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    '전체 채팅방',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/grocerry/makeroom');
                    },
                    icon: Icon(Icons.add_circle_outlined)
                ),
              ],
            ),
            _buildChatList(), // 리얼 아이템 나열한 친구
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'Keells Deals',
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
            _buildDealList()
             */
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    var items = CategoryList();
    return Container(
      height: 140,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: 95,
              height: 95,
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(data.image),
                iconSize: 45,
                color: Colors.black38,
                onPressed: (){
                  if(data.name == '게임'){
                    Navigator.pushNamed(context, '/grocerry/game');
                  }else if(data.name == '스포츠'){
                    Navigator.pushNamed(context, '/grocerry/sports');
                  }else if(data.name == '음악'){
                    Navigator.pushNamed(context, '/grocerry/music');
                  }else if(data.name == '공부'){
                    Navigator.pushNamed(context, '/grocerry/study');
                  }
                },
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
            Text(data.name),
          ]);
        },
      ),
    );
  }

  Widget _buildChatList() {
    //var items = ChatUsers();
    return Container(
      height: 350,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: chatUsers.length, // 채팅방 수
        itemBuilder: (context, index) {
          //var data = items[index];
          return  ChatRoomList(
            name: chatUsers[index].name,
            room_ex: chatUsers[index].room_ex,
            imageUrl: chatUsers[index].imageURL,
          );
          /*Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.all(5),
                  width: 380,
                  height: 80,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.videogame_asset_outlined,
                          size: 40,
                          color: Colors.black38,
                        ),
                        title: Text('방 제목'),
                        subtitle: Text(
                            '채팅방 설명'),
                        onTap: (){
                          /*enter the chat room*/
                        },
                        //trailing: const Divider(thickness: 1,),
                      ),
                    ],
                  ),
                ),
              ]);*/
        },
      ),
    );
  }

  List<Product> CategoryList() {
    var list = List<Product>();

    var data1 = Product('게임', Icons.videogame_asset_outlined);
    // 이름, 이미지를 넣을 수 있다.
    list.add(data1);
    var data2 = Product('스포츠', Icons.sports_basketball_outlined);
    list.add(data2);
    var data3 = Product('음악', Icons.music_video);
    list.add(data3);
    var data4 = Product('공부', Icons.menu_book_outlined);
    list.add(data4);

    return list;
  }

  List<Product> ChatRooms() {
    var list = List<Product>();

    var data1 = Product('게임', Icons.videogame_asset_outlined);
    // 이름, 이미지를 넣을 수 있다.
    list.add(data1);
    var data2 = Product('스포츠', Icons.sports_basketball_outlined);
    list.add(data2);
    var data3 = Product('음악', Icons.music_video);
    list.add(data3);
    var data4 = Product('공부', Icons.menu_book_outlined);
    list.add(data4);

    return list;
  }

  List<ChatUsers> chatUsers = [
    ChatUsers(name: "농구하실 분", room_ex: "목요일 히딩크 7시", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "토익 스터디", room_ex: "일주일 세번", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "A", room_ex: "AAA", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "B", room_ex: "BBB", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "C", room_ex: "CCC", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "D", room_ex: "DDD", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "E", room_ex: "EEE", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
    ChatUsers(name: "F", room_ex: "FFF", imageURL: "http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg"),
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
  int favorite = -1; // temporary
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
                  IconButton(
                    icon: favorite==-1?
                    Icon(Icons.favorite_border_outlined):Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: (){
                      setState(() {
                        favorite *= -1;
                        // -1: empty , 1: fill
                        print("pressed");
                      });
                    },
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

/*
* version info = favorite button icon added (not DB)
*
* */