import 'package:flutter/material.dart';
import 'package:sqflite_sample/repository/sql_database.dart';
import 'package:sqflite_sample/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SqlDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}