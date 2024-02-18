import 'package:myclock/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDateTime = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static late Database _database;
  static late AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialeDatabase();
    }
    return _database;
  }

  Future<Database> initialeDatabase() async {
    var dir = await getDatabasesPath();
    var path = '${dir}alarm.db';

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm(
          $columnId integer primary key autoincrement,
          $columnTitle test not null,
          $columnDateTime test not null,
          $columnPending integer,
          $columnColorIndex integer)
          ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    db.insert(tableAlarm, alarmInfo.toMap() );
  }
}
