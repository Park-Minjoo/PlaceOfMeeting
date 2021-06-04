import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MyAccountPage extends StatelessWidget {



  Future db_user_info(TextEditingController search_term) async {
    int gender;
    int religion;
    int job;
    String date_of_birth;
    String email;
    String phone_num;
    String name;
    String memo;

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    //print('SELECT title, count FROM rooms WHERE title LIKE \'\%${search_term.text}\%\'');
    var result = await conn.query('SELECT gender, date_of_birth, email, phone_num FROM login_info WHERE ID = 8');
    var info = await conn.query('SELECT name, memo, religion, job FROM person_info WHERE ID = 8 ');
    if( result.isNotEmpty ) {
      for (var row in result) {
        gender = row[0].toInt(); date_of_birth = row[1]; email = row[2]; phone_num = row[3];
      }
    }

    if( info.isNotEmpty) {
      for (var row in info) {
        name = row[0]; memo = row[1]; religion = row[2]; job = row[3];
      }
    }

    conn.close();
    return new USER(gender, religion, job, date_of_birth, email, phone_num, name, memo);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
//          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:20),
              padding: EdgeInsets.only(left:16, right: 16),
              child: Card(
                shadowColor: Colors.blueAccent,
                elevation: 10,
                child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 30, top: 5),
                        padding: EdgeInsets.only(top:10),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "내 정보",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                          ],
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left:30, right: 30, top:20, bottom: 15),
                        child: Row(
                          children: <Widget> [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20),
                            ),

                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(right: 125,bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                              "김진일",
                                              style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                        ],
                                      )
                                  ),
                                  Text(
                                      "21900195@handong.edu",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),


                    Padding(
                      padding: EdgeInsets.only(top:20),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Row(
                                children: <Widget> [
                                  Text("생년월일",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                ],
                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: <Widget> [
                                  Text("2000.01.26",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )
                                  ),
                                ],
                              )
                          ),

                          Padding(
                              padding: EdgeInsets.only(top: 20)
                          ),
                          Container(
                              child: Row(
                                children: <Widget> [
                                  Text("휴대폰 번호",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                ],
                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: <Widget> [
                                  Text("010-4160-9587",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )
                                  ),
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20)
                          ),

                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,

                            children: <Widget> [
                              Container(
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  child: Column(
                                    children: [
//                                      Row(
//                                        children: <Widget> [
                                      Container(
                                        child: Text("MBTI",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 5),
//                                  padding: EdgeInsets.only(left: 45, right: 30),
                                          child: Row(
                                            children: <Widget> [
                                              Text("ESTJ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )
                                              ),
                                            ],
                                          )
                                      )
//                                        ],
//                                      )
                                    ],
                                  )
                              ),

                              Padding(
                                  padding: EdgeInsets.only(left: 10)
                              ),


                              Container(
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  child: Column(
                                    children: <Widget> [
                                      Container(
                                        child: Text("직업",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),

                                      Container(
//                                          margin: EdgeInsets.only(top: 5),
//                                  padding: EdgeInsets.only(left: 30, right: 30),
                                          child: Row(
                                            children: <Widget> [
                                              Text("대학생",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )
                                              ),
                                            ],
                                          )
                                      )
                                    ],
                                  )
                              ),

                              Padding(
                                  padding: EdgeInsets.only(left: 10)
                              ),

                              Container(
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  child: Column(
                                    children: <Widget> [
                                      Container(
                                        child: Text("종교",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),

                                      Container(
//                                          margin: EdgeInsets.only( top: 5),
//                                  padding: EdgeInsets.only(left: 30, right: 30),
                                          child: Row(
                                            children: <Widget> [
                                              Text("기독교",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )
                                              ),
                                            ],
                                          )
                                      )
                                    ],
                                  )
                              ),


                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top:8),
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.only(top: 20)
                          ),

                          Container(
                              child: Row(
                                children: <Widget> [
                                  Text("자기 소개",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                ],
                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: <Widget> [
                                  Flexible(
                                    child:Text("안녕하세요~ 반갑습니다.",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )
                                    ),
                                  )
                                ],
                              )
                          ),

                          Padding(padding: EdgeInsets.only(bottom: 100)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            )


          ],

        ),
      ),
    );
  }

}

//gender, date_of_birth, email, phone_num
//name, memo, religion, job
class USER{
  int gender;
  int religion;
  int job;
  String date_of_birth;
  String email;
  String phone_num;
  String name;
  String memo;

  USER(int g, int r, int j, String d, String e, String p, String name, String memo) {
    this.gender = g ; this.religion = r; this.job = j ;
    this.date_of_birth = d; this.email = e; this.phone_num = p; this.name = name; this.memo = memo;
  }
}
