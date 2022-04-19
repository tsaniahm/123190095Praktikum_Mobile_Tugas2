import 'package:flutter/material.dart';
import 'package:tugas2/model/register_model.dart';
import 'package:tugas2/shared_preference/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  initiateLocalDB();
  runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RegisterModelAdapter());
  await Hive.openBox<RegisterModel>("register");
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage()
    );
  }
}
