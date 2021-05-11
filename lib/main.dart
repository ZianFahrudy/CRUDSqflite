import 'package:flutter/material.dart';
import 'package:sqflite_demo/db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async {
                final table = await DBHelper.instance.insert({
                  DBHelper.columnName: 'Hana',
                  DBHelper.columnJK: "Perempuan",
                  DBHelper.columnStatus: "Cucu",
                });

                print(table);
              },
              child: Text('insert'),
              color: Colors.pink,
            ),
            FlatButton(
              onPressed: () async {
                List<Map<String, dynamic>> row =
                    await DBHelper.instance.queryAll();

                print(row);
              },
              child: Text('query'),
              color: Colors.amber,
            ),
            FlatButton(
              onPressed: () async {
                final updated = await DBHelper.instance.update({
                  DBHelper.columnId: 2,
                  DBHelper.columnName: 'Mark',
                });

                print(updated);
              },
              child: Text('update'),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () async {
                await DBHelper.instance.delete(1);
              },
              child: Text('delete'),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
