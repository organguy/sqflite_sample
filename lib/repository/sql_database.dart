import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sample/models/sample_data.dart';

class SqlDatabase{
  static final SqlDatabase instance = SqlDatabase._instance();

  Database? _database;

  SqlDatabase._instance(){
    _initDatabase();
  }

  factory SqlDatabase(){
    return instance;
  }

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }

    await _initDatabase();
    return _database!;
  }

  Future<void> _initDatabase() async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'sample.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _databaseCreate,
    );
  }

  void _databaseCreate(Database db, int version) async{
    await db.execute('''
      create table ${SampleData.tableName}(
        ${SampleFileds.id} integer primary key autoincrement,
        ${SampleFileds.name} text not null,
        ${SampleFileds.yn} integer not null,
        ${SampleFileds.value} double not null,
        ${SampleFileds.createdAt} text not null
      )
    ''');
  }

  void closeDatabase() async{
    if(_database != null){
      await _database!.close();
    }
  }
}