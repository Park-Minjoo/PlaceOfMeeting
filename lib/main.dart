import 'package:flutter/material.dart';
import 'package:flutter_widgets/animation/animated_bottom_bar.dart';
import 'package:flutter_widgets/grocerry_kit/chatroom.dart';
import 'package:flutter_widgets/grocerry_kit/category/category_detail.dart';
import 'package:flutter_widgets/grocerry_kit/home_page.dart';
import 'package:flutter_widgets/grocerry_kit/login.dart';
import 'package:flutter_widgets/grocerry_kit/make_room.dart';
import 'package:flutter_widgets/grocerry_kit/manage_list.dart';
import 'package:flutter_widgets/grocerry_kit/managa_one.dart';
import 'package:flutter_widgets/grocerry_kit/manage_list.dart';
import 'package:flutter_widgets/grocerry_kit/managa_one.dart';
import 'package:flutter_widgets/grocerry_kit/my_account.dart';
import 'package:flutter_widgets/grocerry_kit/my_profile.dart';
import 'package:flutter_widgets/grocerry_kit/profile.dart';
import 'package:flutter_widgets/grocerry_kit/search.dart';
import 'package:flutter_widgets/grocerry_kit/sub_pages/home_list.dart';
import 'package:flutter_widgets/grocerry_kit/welcome.dart';
import 'package:flutter_widgets/note_app/edit_note.dart';

import 'grocerry_kit/board_pages/board_room.dart';
import 'grocerry_kit/signup.dart';
import 'grocerry_kit/sub_pages/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Kit',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
      ),
      routes: {
        //    '/': (context) => AnimatedBottomBar(),
        '/': (context) => WelcomePage(),
        '/grocerry/signup': (context) => SignupPage(),
        '/grocerry/login': (context) => LoginPage(),
        '/grocerry/home': (context) => HomePage(),
        '/grocerry/cart': (context) => CartPage(),
        '/grocerry/chatroom': (context) => ChatRoomPage(),
        '/grocerry/profile': (context) => MyChatRoomList(),
        '/grocerry/board' : (context) => BoardPage(),
//           '/grocerry/sub_pages/home_list': HomeList(),
        //   '/grocerry/study': (context) => StudyPage(),
        //   '/grocerry/sports': (context) => SportsPage(),
        //    '/grocerry/music': (context) => MusicPage(),
        '/grocerry/makeroom': (context) => makeRoomPage(),
        '/grocerry/search': (context) => SearchPage(),
        '/grocerry/my_account': (context) => MyAccountPage(),
        '/grocerry/manage': (context) => ManageList(),
        '/grocerry/manage_one': (context) => ManageOne(),

        AnimatedBottomBar.tag: (context) => AnimatedBottomBar(),
        EditNote.tag: (context) => EditNote(),
      },
//      onGenerateRoute: _getRoute,
    );
  }
}