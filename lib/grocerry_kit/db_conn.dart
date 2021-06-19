import 'package:mysql1/mysql1.dart';

class Database{
  static ConnectionSettings getConnection () {
    return ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    );
  }
}