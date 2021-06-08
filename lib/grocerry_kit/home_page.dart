import 'package:flutter/material.dart';
import 'package:flutter_widgets/grocerry_kit/my_profile.dart';
import 'package:flutter_widgets/grocerry_kit/profile.dart';
import 'package:flutter_widgets/grocerry_kit/search.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'sub_pages/home_list.dart';
import 'sub_pages/cart.dart';
import 'package:flutter_widgets/grocerry_kit/my_account.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    // 여기서 bottom bar 변경
    HomeList(),
    SearchPage(),
    MyChatRoomList(),
    MyAccountPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      /*
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ]
        ),
      ), */
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
      '좋은사람 있으면 소개시켜줘',
      style: TextStyle(color: Colors.white),
    ),
    actions: <Widget>[
      SizedBox(
        width: 10,
      ),
      IconButton(
        icon: Icon(Icons.notifications_none, color: Colors.white),
        onPressed:(){
          Navigator.pushNamed(context, '');
        }
      ),

      SizedBox(
        width: 10,
      ),
    ],
  );
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
