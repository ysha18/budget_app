import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'service/accountTypeService.dart';

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

  @override
  Widget build(BuildContext context) {
    // trying to display records
    AccountTypeService accountTypeService = AccountTypeService();
    var list = accountTypeService.listAll();

    // trying to insert in DB
    // insert();

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
            GestureDetector(
              onTap: (){
                print("tapped");
              },
              child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.adb,
                      size: 80.0,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Som text",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF8D8E98),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: null,
                builder: null;
            )
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
