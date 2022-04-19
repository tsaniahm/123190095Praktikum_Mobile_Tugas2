import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas2/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas2/hive/register.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas2/model/register_model.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final String usernameDB = "mobile";
  final String passwordDB = "mobile123";

  late SharedPreferences logindata;
  late bool newuser;
  bool status = true;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
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
      ElevatedButton(
        onPressed: () {
          String username = username_controller.text;
          String password = password_controller.text;
          _prosesLogin(username, password);
          _prosesCheck();
        },
        child: Text("Log-In"),
      ),
      Padding(
          padding:  const EdgeInsets.all(15.0),
        child:  ElevatedButton(
          child: Text('Register'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ),
      ],
    ),
    ),
    );
  }

  void _prosesLogin(String username, String password) async {
    if (username == usernameDB && password == passwordDB) {
      logindata.setBool('login', false);
      logindata.setString('username', username);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  void _prosesCheck() async{
    status =  logindata.getBool("login") ?? true;
    if(status == false){
      _showToast("Successfuly Login", duration: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
    }else{
      _showToast("Failed to Login", duration: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
    }
  }

  void _showToast(String msg, {Toast? duration, ToastGravity? gravity}){
    Fluttertoast.showToast(msg: msg, toastLength: duration, gravity: gravity);
  }



}
