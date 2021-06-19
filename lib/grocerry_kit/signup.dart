import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

enum Controller{
      idController,
      pwdController,
      pwd2Controller,
      nameController,
      dateController,
      emailController,
      phoneController
}

class _SignupPageState extends State<SignupPage> {
  final idController = TextEditingController();
  final pwdController = TextEditingController();
  final pwd2Controller = TextEditingController();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final adressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _item = ['Man', 'Woman'];
  final _majorItem = ['NULL','Business', 'Economics', 'Computer Science', 'English', 'Psychology', 'Law', 'Music', 'Electron'];
  final _nationItem = ['Korea','NULL'];
  final _cityItem = ['Pohang','Seuol','Yangju','Daegu', 'Goyang', 'Busan'];
  var _selected = 'Man';
  var _major1 = 'NULL';
  var _major2 = 'NULL';
  var _nation = 'Korea';
  var _city = 'Pohang';


  bool _dupcheck = false;

  Future<int> checkdup(TextEditingController id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    var results = await conn.query(
        'select user_id from login_info where user_id = ?', [id.text]);

    conn.close();

    if(results.isNotEmpty){
      print('중복ㅋㅋㅋ'); // ?
      return 1;
    }
    else return 0;
  }

  Future main(TextEditingController id, TextEditingController pwd, TextEditingController name, TextEditingController date, String gender,
      TextEditingController email, TextEditingController pnum ) async{

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
        ));

    var result = await conn.query(
         'insert into login_info values (?, ?, ?, ?, ?, ?, ?)',
          [0, gender=='Man'? 1 : 0, date.text, id.text, pwd.text, email.text, pnum.text]
    );

    conn.close();
  }

  Future majorIn(String m1, String m2) async{

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    var result = await conn.query(
        'insert into major values (?, ?, ?)',
        [0, m1, m2]
    );

    conn.close();
  }

  Future residenceIn(String nation, String city, TextEditingController adress) async{

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    var result = await conn.query(
        'insert into residence values (?, ?, ?, ?)',
        [0, nation, city, adress.text]
    );

    conn.close();
  }

  String convert(int num){
    if(num == 0) return 'ID';
    else if(num == 1) return 'Passward';
    else if(num == 2) return 'Passward Confirm';
    else if(num == 3) return 'Date of Birth';
    else if(num == 4) return 'Name';
    else if(num == 5) return 'Email';
    else if(num == 6) return 'Phone_num';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body:
        ListView(
          key: _formKey,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(0.0, 2.0),
                      blurRadius: 25.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              alignment: Alignment.topCenter,
              child: Expanded(
                child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(16),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/grocerry/login');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        'Welcome to Place of Meeting.',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        'Let\'s get started',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextFormField(
                        controller: idController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'ID',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () async {
                                  var result;
                                  result = await checkdup(idController);
                                  if(result == 0){
                                    _dupcheck = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Available ID!'),
                                        ),
                                    );
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Invalid ID, Please try another ID.'),
                                      ),
                                    );
                                  }
                              },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: pwdController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Passward',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: Icon(Icons.lock),
                        ),

                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextFormField(
                        controller: pwd2Controller,
                        obscureText: true,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Passward Reconfirm',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: Icon(Icons.lock),

                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: dateController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Date of birth(ex 1999.02.05)',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Name',
                         // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23, right: 16, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'Gender       ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                            DropdownButton(
                              value: _selected,
                              items: _item.map(
                                      (value){
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }
                              ).toList(),
                              onChanged: (value){
                                setState(() {
                                  _selected = value;
                                });
                              },
                            ),
                          ],
                        ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: phoneController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone-num',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23, right: 16, top: 8, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            'Major1       ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          DropdownButton(
                            value: _major1,
                            items: _majorItem.map(
                                    (value){
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                _major1 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23, right: 16, top: 0, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            'Major2       ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          DropdownButton(
                            value: _major2,
                            items: _majorItem.map(
                                    (value){
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                _major2 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23, right: 16, top: 0, bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            'Nation      ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          DropdownButton(
                            value: _nation,
                            items: _nationItem.map(
                                    (value){
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                _nation = value;
                              });
                            },
                          ),
                          SizedBox(width: 40),
                          Text(
                            'City     ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          DropdownButton(
                            value: _city,
                            items: _cityItem.map(
                                    (value){
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                _city = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
                      child: TextField(
                        controller: adressController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Adress Detail',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                          child: IconButton (
                            color: Colors.white,
                            onPressed: () {// 텍스트폼필드의 상태가 적함하는
                              int flag = 0;
                              Controller.values.forEach((element) {
                                if(idController.text.isEmpty) flag = 0;
                                else if(pwdController.text.isEmpty) flag = 1;
                                else if(pwd2Controller.text.isEmpty) flag = 2;
                                else if(dateController.text.isEmpty) flag = 3;
                                else if(nameController.text.isEmpty) flag = 4;
                                else if(emailController.text.isEmpty) flag = 5;
                                else if(phoneController.text.isEmpty) flag = 6;
                                else flag = 100;
                              });
                              if(flag == 100 && _dupcheck){
                                main(idController, pwdController, nameController, dateController, _selected, emailController, phoneController);
                                majorIn(_major1, _major2);
                                residenceIn(_nation, _city, adressController);
                                Navigator.pushNamed(context, '/');
                              }
                              else if(_dupcheck == false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Check Your ID Duplication',
                                      textScaleFactor: 1.4,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          convert(flag) + ' Must Be Not Empty!',
                                          textScaleFactor: 1.4,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                              }
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )),
                  ],
              ),
            ))
          ],
        )
    );
  }
}
