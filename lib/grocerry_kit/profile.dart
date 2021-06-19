
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'manage_one.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';


class ProfileList extends StatefulWidget {
  final int id;
  ProfileList({Key key, @required this.id}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileList();
  }
}
class Manage{
  String title;
  String description;
  int count;

  Manage(this.title, this.description, this.count);
}

class _ProfileList extends State<ProfileList> {
  @override
  List<Manage> _list = [];
  int num;

  Future<int> getData(int uid) async{
    List<Manage> temp = [];
    int n_data;
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    var results = await conn.query(
        'select title, description, count '
            'from rooms, room_people where room_people.room_id = rooms.room_id AND room_people.ID = ?', [uid]);
    conn.close();

    for(var row in results) {
      print('title: ${row[0]}, desc: ${row[1]}, count: ${row[2]}');
      Manage m = new Manage(row[0], row[1], row[2]);
      temp.add((m));
      //   _list.add(temp);
    }

    //   n_data = results.length;
    print(n_data);

    num = results.length;
    _list = temp;
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 3),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    int uid = widget.id;
    getData(uid);

    return Scaffold(
        body: SingleChildScrollView(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
              child: FutureBuilder<String>(
                future: _calculation,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  List<Widget> children;
                  if(snapshot.hasData){
                    children = <Widget>[
                      SizedBox(height: 23),
                      Text(
                        'Manage My Own Room',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      _myList(num, _list, uid),
                    ];
                  }else if (snapshot.hasError) {
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
                      Padding(padding: EdgeInsets.only(top:300)),
                      SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                        width: 40,
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
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
            )
        )
    );
  }
}

Widget _myList(int n, List<Manage> mlist, int uid){
  if(n==0){
    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Icon(
              Icons.add_shopping_cart, size: 100,
            ),
          ],
        )
    );
  }
  else{
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 75,
          color: index % 2 == 0 ? Colors.green : Colors.green[200],
          child: ListTile(
            leading: Icon(Icons.star, color: Colors.amberAccent),
            title: Text(
              '${mlist[index].title}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ), //{entries[index]}'),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(''
                  '${mlist[index].description}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            // trailing: IconButton(
            //     icon: Icon(Icons.people_alt_outlined, color: Colors.white, size: 35),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => ManageOne(id: uid))
            //       );
            //     }
            // ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
