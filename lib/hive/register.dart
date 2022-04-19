import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas2/model/register_model.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Box<RegisterModel> localDB = Hive.box<RegisterModel>("register");

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Register"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.all(15.0),
              child:  ElevatedButton(
                child: Text('Register'),
                onPressed: (){
                  localDB.add(RegisterModel(username: username_controller.text, password: password_controller.text));
                  username_controller.clear();
                  password_controller.clear();
                  setState(() {});
                },
              ),
            ),
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {

    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: localDB.listenable(),
          builder: (BuildContext context, Box<dynamic> value, Widget? child) {
            if (value.isEmpty) {
              return Center(
                child: Text("Data Kosong"),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text("${localDB.getAt(index)!.username} + ${localDB.getAt(index)!.password}");
              },
              itemCount: localDB.length,
            );
          }),
    );
  }
}
