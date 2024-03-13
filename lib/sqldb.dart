import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    // place to save data in devices
    String databasePath = await getDatabasesPath();
    //place name of database
    String path = join(databasePath, 'notes.db');
    //to create database
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 6, onUpgrade: _onupgrade);
    return mydb;
  }

  _onupgrade(Database db, int oldVersions, int newVersions)async {
    print('===============onupgrade');
   // await db.execute('ALTER TABLE notes ADD COLUMN color TEXT ');


  }

  _onCreate(Database db, int versions) async {
    await db.execute('''
CREATE TABLE "notes"(
  id INTEGER  NOT NULL  PRIMARY KEY AUTOINCREMENT  ,
  title TEXT NOT NULL,
  note TEXT NOT NULL,
  color TEXT NOT NULL
  )

''');
    print('create database and table ==========');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  mydeleteDatabase()async{
    String databasePath = await getDatabasesPath();
    //place name of database
    String path = join(databasePath, 'notes.db');
    await deleteDatabase(path);

  }

  //========================================
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table,Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table,values);
    return response;
  }

  update(String table,Map<String, Object?> values,String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table,values,where: myWhere);
    return response;
  }

  delete(String table,String? where,) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: where);
    return response;
  }
}
