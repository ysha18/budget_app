import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


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

  Future<Database> _openDB() async {
    return await openDatabase('../database/budget_db.db');
  }

  Future<void> getRecords() async {
    // Get the DB
    var database = _openDB();
    List<Map> list = await database.then((db) => db.rawQuery('SELECT * FROM account_type'));

    List<Map> expectedList = [
      {'id': 1, 'name': 'CHECKING', 'description': 'Checking account type'},
      {'id': 2, 'name': 'SAVINGS', 'description': 'Savings account type'}
    ];
    print(list);
    print(expectedList);


  }

  @override
  Widget build(BuildContext context) {
    // trying to display records
    getRecords();
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