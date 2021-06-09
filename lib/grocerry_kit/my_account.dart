import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MyAccountPage extends StatefulWidget {
  final int id;
  MyAccountPage({Key key, @required this.id}) : super(key:key);

  @override
  State<StatefulWidget> createState() => new _MyAccountPage();
}


class _MyAccountPage extends State<MyAccountPage> {
  bool isLoading = true;
  USER user;
  List<String> job = ['없음','학생'];
  List<String> religion = ['없음', '기독교'];

  Future <String> db_user_info(int id) async {
    var gender;
    int religion;
    int job;
    String date_of_birth;
    String email;
    String phone_num;
    String name;
    String memo;
    String MBTI;
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    //print('SELECT title, count FROM rooms WHERE title LIKE \'\%${search_term.text}\%\'');
    var result = await conn.query('SELECT gender, date_of_birth, email, phone_num FROM login_info WHERE ID = ?', [id.toString()]);
    var info = await conn.query('SELECT name, memo, religion, job, MBTI FROM person_info WHERE ID = ?', [id.toString()]);

    if( result.isNotEmpty ) {
      for (var row in result) {
        gender = row[0]; date_of_birth = row[1]; email = row[2]; phone_num = row[3];
        print(row[0] + " " + date_of_birth);
      }
    }

    if( info.isNotEmpty) {
      for (var row in info) {
        name = row[0]; memo = row[1]; religion = row[2].toInt(); job = row[3].toInt(); MBTI = row[4];
        print(row[0]);
      }
    }

    conn.close();
    user = new USER(gender, religion, job, date_of_birth, email, phone_num, name, memo, MBTI);
  }
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  void initState() {
    super.initState();
    db_user_info(widget.id);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
          child: FutureBuilder<String>(
            future: _calculation, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Column(
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
                                                          user.name,
                                                          style: TextStyle(
                                                            fontSize: 21,
                                                            fontWeight: FontWeight.bold,
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              Text(
                                                  user.email,
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
                                              Text(user.date_of_birth,
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
                                              Text(user.phone_num,
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
                                                          Text(user.MBTI,
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
                                                          Text(job[user.job],
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
                                                          Text(religion[user.religion],
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
                                                child:Text(user.memo,
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
                ];
              } else if (snapshot.hasError) {
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
                  Padding(padding: EdgeInsets.only(top:100)),
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 40,
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...', style: TextStyle(fontSize: 30)),
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
        ),
      ),
    );
  }

}

//gender, date_of_birth, email, phone_num
//name, memo, religion, job
class USER{
  var gender;
  int religion;
  int job;
  String date_of_birth;
  String email;
  String phone_num;
  String name;
  String memo;
  String MBTI;
  USER(this.gender, this.religion, this.job, this.date_of_birth, this.email, this.phone_num, this.name, this.memo, this.MBTI) ;
}