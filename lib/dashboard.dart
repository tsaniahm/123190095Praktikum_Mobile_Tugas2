import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas2/shared_preference/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late SharedPreferences logindata;
  late String username;

  bool status = false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {
                    _processLogout();
                    _prosesCheck();
                  },
                  child: Text('Logout'),
              )
            ),
          ],
        ),
      ),
    );
  }

  void _processLogout (){
    logindata.setBool('login', true);
    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Homepage()));
}

  void _prosesCheck() async{
    status =  logindata.getBool("login") ?? false;
    if(status == true){
      _showToast("Successfuly Logout", duration: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
    }
  }

  void _showToast(String msg, {Toast? duration, ToastGravity? gravity}){
    Fluttertoast.showToast(msg: msg, toastLength: duration, gravity: gravity);
  }
}

