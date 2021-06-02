import 'package:flutter/material.dart';

class makeRoomPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
  //          onPressed: () => Navigator.of(context).pop(),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.house, color: Colors.white),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text(
                'Make a Room',
                style: TextStyle(color: Colors.white),
              ),
            ]
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:20),
            ),
            Text(
              "Category",
              style: TextStyle(
                fontFamily: 'Raleway',
                package: 'awesome_package',
                color: Colors.green,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20, right:20, top: 5, bottom:5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top:5, bottom:5),
                  ),
                  category_items_first_line(),
                  Padding(
                    padding: EdgeInsets.only(top:10, bottom:10),
                  ),
                  category_items_second_line(),
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      Text(
                          "방 제목: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,

                          )

                      ),
                      SizedBox(
                          width: 280, child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "제목",
                        ),
                      )
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top:5),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget> [
                      Text(
                        "비밀번호 설정: ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      radioButtonWidget(),
                    ]
                  )
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      Text(
                          "비밀번호: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(
                          width: 270, child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "비밀번호",
                        ),
                      )
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),

            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      Text(
                          "카테고리: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(
                          width: 270, child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "카테고리",
                        ),
                      )
                      )
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top:10),
            ),

            RaisedButton(
              onPressed: () { }, // 버튼 클릭 시 이벤트
              padding: EdgeInsets.only(left: 150, right:150),
              child: Text(
                "방 생성",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              color: Colors.green,
            )
          ],
        )
      )
    );
  }
}


enum SingingCharacter { lafayette, jefferson }

class radioButtonWidget extends StatefulWidget{
  const radioButtonWidget({Key key}) : super(key: key);
  @override
  State<radioButtonWidget> createState() => _radioButtonWidget();
}

class _radioButtonWidget extends State<radioButtonWidget> {
  SingingCharacter _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      child: SizedBox(
        width:200,
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<SingingCharacter>(

              value: SingingCharacter.lafayette,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Text("있음"),
            Radio<SingingCharacter>(
              value: SingingCharacter.jefferson,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Text("없음"),
          ],
        ),
      ),
    );
  }
  
}

category_items_first_line(){
  return Row(
      children: <Widget> [
        Padding(
            padding: EdgeInsets.only(left: 5, right: 5)
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.directions_walk),
            ),
            Text("산책"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.sports_soccer),
            ),
            Text("축구"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.sports_basketball),
            ),
            Text("농구"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.sports_tennis),
            ),
            Text("테니스"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.sports_volleyball),
            ),
            Text("배구"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.computer),
            ),
            Text("컴퓨터"),
          ],
        ),

      ]
  );
}

category_items_second_line(){
  return Row(
      children: <Widget> [
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5)
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.local_taxi),
            ),
            Text("택시"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.music_note),
            ),
            Text("음악"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.palette),
            ),
            Text("미술"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.sports_tennis),
            ),
            Text("테니스"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.people_alt),
            ),
            Text("친구"),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.edit_rounded),
            ),
            Text("공부"),
          ],
        ),
      ]
  );
}