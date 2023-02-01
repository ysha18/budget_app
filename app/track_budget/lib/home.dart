import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<Database> _openDB() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'budget_db.db');

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("database", "budget_db.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }

// open the database
    var db = await openDatabase(path);
    return db;

  }

  void insert(){
    _openDB().then((db) =>  insertIntoDb(db));
  }

  void insertIntoDb(Database database) async{
    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO ACCOUNT_TYPE (name, description) VALUES ("some name", "some description")');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO ACCOUNT_TYPE (name, description) VALUES (?, ?)',
          ['another name', 'another description']);
      print('inserted2: $id2');
    });

  }

  Future<void> getRecords() async {
    // Get the DB
    var database = _openDB();
    List<Map> list = await database.then((db) => db.rawQuery('SELECT * FROM account_type'));
    print(list);

  }

  @override
  Widget build(BuildContext context) {
    // trying to display records
    getRecords();

    // trying to insert in DB
    insert();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}