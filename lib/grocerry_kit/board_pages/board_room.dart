import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import '../home_page.dart';
import 'design_course_app_theme.dart';

class BoardPage extends StatefulWidget {
  final int room_id;
  int id;
  BoardPage({Key key, @required this.room_id,  @required this.id}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  Map<Map<String,int>, int> room_info = new Map<Map<String,int>, int>() ;
  final List<String> title_set = new List<String>();
  final List<int> count_set = new List<int>();
  final List<String> des_set = new List<String>();
  final List<String> date_set = new List<String>();
  // final List<DateFormat> formatter = new List<DateFormat>(3);
  // final List<String> formatted = formatter.format(date_set);


  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  Future<int> getRoomInfo(int room_id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    var results = await conn.query(
        // 'select title, count, description, dueday from rooms WHERE room_id = ?', [room_id]);
    'select title, count, description,  date_format(dueday, \'%Y-%m-%d\') from rooms WHERE room_id = ?', [room_id]);

    if(results.isNotEmpty){
      for(var row in results){
        title_set.add(row[0]);
        count_set.add(row[1].toInt());
        des_set.add(row[2]);
        date_set.add(row[3].toString());
        print(row[3].toString());
        // title_count_set.addAll({row[0]: row[1].toInt()}) ;
        // selected_set.add(row[2].toInt());
        // print('debug');
        // print(row[0]);
        // print(row[1]);
      }
    }

    // print(title_set.length + " " + count_set.length + " " + des_set.length + " " + date_)
  }

  Future joinRoom(int uid, int room_id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));
    var results = await conn.query(
      'insert into room_people values (?, ?)', [uid, room_id]);

    for(var col in results){
      print(col);
    }

    conn.close();
  }
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
    getRoomInfo(widget.room_id);
  }

  @override
  Widget build(BuildContext context) {
    // int uid;
    // uid = widget.id;
    // int room_id;
    // room_id = widget.room_id;
    // print("room id: " + widget.room_id.toString());
    // print("room title: " + title_set[0].toString());
    // print("room count: " + count_set[0].toString());
    // print("date: " + date_set.toString());

    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return Container(
              color: DesignCourseAppTheme.nearlyWhite,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Image.asset('image.png'),
                        ),
                      ],
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: DesignCourseAppTheme.nearlyWhite,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            child: Container(
                              constraints: BoxConstraints(
                                  minHeight: infoHeight,
                                  maxHeight: tempHeight > infoHeight
                                      ? tempHeight
                                      : infoHeight),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32.0, left: 18, right: 16),
                                    child: Text(
                                      title_set[0].toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 8, top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '~' + date_set[0].toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: Colors.lime,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: <Widget>[
                                          // getTimeBoxUI('24', 'Classe'),
                                          // getTimeBoxUI('2hours', 'Time'),
                                          getTimeBoxUI(count_set[0].toString(), 'Seat'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 500),
                                      opacity: opacity2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, top: 8, bottom: 8),
                                        child: Text(
                                          // 'We are going to study TOEIC Together, let us study HARD together!',
                                          des_set[0].toString(),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                            letterSpacing: 0.27,
                                            color: DesignCourseAppTheme.grey,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, bottom: 16, right: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 48,
                                            height: 48,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: DesignCourseAppTheme.nearlyWhite,
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                                border: Border.all(
                                                    color: DesignCourseAppTheme.grey
                                                        .withOpacity(0.2)),
                                              ),
                                              child: IconButton(
                                                  icon: Icon(Icons.add, color: Colors.lightGreen),
                                                  onPressed:(){
                                                    Navigator.pushNamed(context, '/grocerry/room');
                                                  }
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.lightGreen,
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.green,
                                                      offset: const Offset(1.1, 1.1),
                                                      blurRadius: 10.0),
                                                ],
                                              ),
                                              child: Center(
                                                child: TextButton(
                                                  onPressed: () async{
                                                    print("dddd");
                                                    var results = await joinRoom(widget.id, widget.room_id);

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => HomePage(id: widget.id))
                                                    );
                                                  }, // 버튼 클릭 시 이벤트
                                                  child: Text(
                                                    'Join Room',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                      letterSpacing: 0.0,
                                                      color: DesignCourseAppTheme
                                                          .nearlyWhite,
                                                    ),
                                                  ),
                                                )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).padding.bottom,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                      right: 35,
                      child: ScaleTransition(
                        alignment: Alignment.center,
                        scale: CurvedAnimation(
                            parent: animationController, curve: Curves.fastOutSlowIn),
                        child: Card(
                          color: Colors.lime,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          elevation: 10.0,
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                color: DesignCourseAppTheme.nearlyWhite,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      child: SizedBox(
                        width: AppBar().preferredSize.height,
                        height: AppBar().preferredSize.height,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                            BorderRadius.circular(AppBar().preferredSize.height),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: DesignCourseAppTheme.nearlyBlack,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
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
    );

  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.lime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}