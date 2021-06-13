import 'package:flutter/material.dart';
import 'package:flutter_widgets/grocerry_kit/my_profile.dart';
import 'package:flutter_widgets/grocerry_kit/profile.dart';
import 'package:flutter_widgets/grocerry_kit/room.dart';
import 'package:flutter_widgets/grocerry_kit/search.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'board_pages/board_room.dart';
import 'manage_list.dart';
import 'sub_pages/home_list.dart';
import 'package:flutter_widgets/grocerry_kit/my_account.dart';



class HomePage extends StatefulWidget {
  final int id;
  HomePage({Key key, @required this.id}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // final Arg arg = ModalRoute.of(context).settings.arguments;
    //  print(arg.uid);
    List<Widget> _widgetList = [
      // 여기서 bottom bar 변경
      HomeList(id: widget.id),
      SearchPage(),
      // MyChatRoomList(),
      MyRoomList(),
      MyAccountPage(id: widget.id),
    ];

    return Scaffold(
      appBar: AppBar(
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
          'Place Of meeting',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageList(id: widget.id))
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('   Home  ', style: TextStyle())),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text('Search', style: TextStyle())),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_outlined,
              ),
              title: Text('Room', style: TextStyle())),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                'My Account',
                style: TextStyle(),
              ))
        ],
      ),
      body: _widgetList[_index],
    );
  }
}

Widget _buildBottomBar(BuildContext con) {
  return BottomNavigationBar(
    // selectedItemColor: Colors.green,
    // unselectedItemColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    currentIndex: 2,
    onTap: (index) {},
    items: [
      BottomNavigationBarItem(
          icon: Icon(
            CartIcons.home,
            color: Colors.black,
          ),
          title: Text('   Store  ', style: TextStyle())),
      BottomNavigationBarItem(
          icon: Icon(
            CartIcons.cart,
          ),
          title: Text('My Cart', style: TextStyle())),
      BottomNavigationBarItem(
          icon: Icon(
            CartIcons.favourites,
          ),
          title: Text('Favourites', style: TextStyle())),
      BottomNavigationBarItem(
          icon: Icon(
            CartIcons.account,
          ),
          title: Text(
            'My Account',
            style: TextStyle(),
          ))
    ],
  );
}