import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

String search_text = "";

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {

  Map<String, int> room_info = new Map<String,int>();

  final textController = TextEditingController();

  final List<String> title = new List<String>();
  final List<int> numofp = new List<int>();

  Future db_search_list(TextEditingController search_term) async {
    Map<String, int> room_info = new Map<String, int>();

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    //print('SELECT title, count FROM rooms WHERE title LIKE \'\%${search_term.text}\%\'');
    var result = await conn.query('SELECT title, count FROM rooms WHERE title LIKE ?', ['%${search_term.text}%']);

    if( result.isNotEmpty ) {
      for (var row in result) {
        room_info.addAll({row[0].toString():row[1].toInt()});
      }
    }

    conn.close();
    return room_info;
  }

  int _index = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Container(
                padding: EdgeInsets.all(10.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 30.0, bottom: 8.0, right: 30.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.green
                    ),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search , color: Colors.green),

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.green)
                        ),

                      ),
                      onChanged: (text) async {
//                        search_text = text.toLowerCase();
                        // 검색 결과
//                        search_text = text;
//                        print(search_text);
                        Map<String, int> result = await db_search_list(textController);
                        setState(() {
                          title.clear(); numofp.clear();
                          if (result.keys != null) {
                            for (var key in result.keys) {
//                            print("KEY:"+key);
                              title.add(key);
                              numofp.add(result[key]);
                              print(key + " " + result[key].toString());
                            }
                          }
                        });
                      },
                    ),
                  )
              ),
//              SearchField(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              // 검색 결과 + 검색 리스트 나열
//              SearchList(room_info),
              Expanded(
                child: Container(
                    height: 450,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: title.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 70,
                          margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget> [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  /*image: const DecorationImage(
                        image:NetworkImage('http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg'),
                        fit: BoxFit.cover,
                      ),*/
                                  //                 borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                      width: 220,
                                      padding: EdgeInsets.only(left: 5, top:5),
                                      height: 30,
                                      child: Text('Title ${title[index]}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 1),),
                                  Container(
                                    width: 220,
                                    height: 20,
                                    padding: EdgeInsets.only(left: 5,),
                                    child: Text('${numofp[index]}'),
                                  )
                                ],
                              ),

                            ],
                          ),
                        );
                      },
                    )
                ),
              )
            ]
          )
        )
      )
    );
  }
}

Widget _buildAppBar() {
  return AppBar(
    centerTitle: true,
    brightness: Brightness.dark,
    elevation: 0,
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    title: Text(
      'SearchPage',
      style: TextStyle(color: Colors.white),
    ),
  );
}


