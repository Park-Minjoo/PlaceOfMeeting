import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'sub_pages/introduce_edit.dart';

class MyAccountPage extends StatefulWidget {
  final int id;
  MyAccountPage({Key key, @required this.id}) : super(key:key);

  @override
  State<StatefulWidget> createState() => new _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> {
  bool isLoading = true;
  USER user;
  // TODO: 기타 나중에 작업
  List<String> job = ['없음','학생', '전문직', '회사원', '자영업', 'CEO', '기타'];
  List<String> religion = ['없음', '기독교', '천주교', '원불교', '불교', '기타'];

  int job_index(String job_t) {
    int idx = 0 ;
    for (int i = 0 ; i < job.length; i++) {
      if (job_t == job[i]) {
        idx = i;
        break;
      }
    }
    return idx;
  }

  int religion_index(String religion_t) {
    int idx = 0 ;
    for (int i = 0 ; i < religion.length; i++) {
      if (religion_t == religion[i]) {
        idx = i ;
        break;
      }
    }
    return idx;
  }

  Future db_update_MBTI(String MBTI) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    await conn.query('UPDATE person_info SET MBTI = ? WHERE ID = ?',[MBTI, widget.id]);

    conn.close();
  }

  Future db_update_job(String job) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    await conn.query('UPDATE person_info SET job = ? WHERE ID = ?',[job_index(job), widget.id]);

    conn.close();
  }

  Future db_update_religion(String religion) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    var result = await conn.query('UPDATE person_info SET religion = ? WHERE ID = ?',[religion, widget.id]);

    if( result.isNotEmpty ) {
      print("RELIGION UPDATE");
    }else {
      print("NOT RELIGION UPDATE!!!");
    }
    conn.close();
  }

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

    var result = await conn.query('SELECT gender, date_of_birth, email, phone_num FROM login_info WHERE ID = ?', [id.toString()]);
    var info = await conn.query('SELECT name, memo, religion, job, MBTI FROM person_info WHERE ID = ?',[id.toString()]);

    if( result.isNotEmpty ) {
      for (var row in result) {
        gender = row[0]; date_of_birth = row[1]; email = row[2]; phone_num = row[3];
        print(row[0] + " " + date_of_birth);
      }
    }

    if( info.isNotEmpty) {
      for (var row in info) {
        name = row[0]; memo = (row[1] == null) ? "없음" : row[1]; religion = (row[2] == null) ? 0 : row[2].toInt();
        job = (row[3] == null) ? 0 : row[3].toInt(); MBTI = (row[4] == null) ? "없음" : row[4];
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
                                            "My information",
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
                                              Text("Birth",
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
                                              Text("Phone number",
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
//                                  padding: EdgeInsets.only(left: 45, right: 30),
                                                      child: DropdownButton<String>(
                                                        value: user.MBTI,
                                                        icon: const Icon(Icons.arrow_downward,size: 14,),
                                                        iconSize: 20,
                                                        elevation: 16,
                                                        style: const TextStyle(color: Colors.deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors.deepPurpleAccent,
                                                        ),
                                                        onChanged: (String newValue) async {
                                                          await db_update_MBTI(newValue);
                                                          setState(() {
                                                            user.MBTI = newValue;
                                                          });
                                                        },
                                                        items: <String>['없음', 'ESTJ', 'ESTP', 'ESFP', 'ESFJ', 'ENTJ', 'ENTP', 'ENFJ', 'ENFP',
                                                          'ISTJ', 'ISTP', 'ISFP', 'ISFJ', 'INTJ', 'INTP', 'INFJ', 'INFP']
                                                            .map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
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
                                                    child: Text("JOB",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                        )
                                                    ),
                                                  ),

                                                  Container(
//                                          margin: EdgeInsets.only(top: 5),
//                                  padding: EdgeInsets.only(left: 30, right: 30),
                                                      child: DropdownButton<String>(
                                                        value: job[user.job],
                                                        icon: const Icon(Icons.arrow_downward,size: 14,),
                                                        iconSize: 20,
                                                        elevation: 16,
                                                        style: const TextStyle(color: Colors.deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors.deepPurpleAccent,
                                                        ),
                                                        onChanged: (String newValue) async {
                                                          await db_update_job(newValue);
                                                          setState(() {
                                                            user.job = job_index(newValue);
                                                          });
                                                        },
                                                        items: job.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                  )
                                                ],
                                              )
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(left: 10)
                                          ),

                                          Container(
                                              padding: EdgeInsets.only(left: 25, right: 15),
                                              child: Column(
                                                children: <Widget> [
                                                  Container(
                                                    child: Text("RELI",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                        )
                                                    ),
                                                  ),

                                                  Container(
                                                      child: DropdownButton<String>(
                                                        value: religion[user.religion],
                                                        icon: const Icon(Icons.arrow_downward,size: 14,),
                                                        iconSize: 20,
                                                        elevation: 16,
                                                        style: const TextStyle(color: Colors.deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors.deepPurpleAccent,
                                                        ),
                                                        onChanged: (String newValue) async {
                                                          await db_update_job(newValue);
                                                          setState(() {
                                                            user.religion = religion_index(newValue);
                                                          });
                                                        },
                                                        items: religion.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
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
                                              Text("MY INTRODUTION",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  )
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 5)),
                                              IconButton(
                                                icon: Icon(Icons.create, color: Colors.grey, size: 22),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => IntroduceEditPage(id: widget.id, comment: user.memo))
                                                  );
                                                }
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
