import 'package:assignment7/screens/dashboard.dart';
import 'package:assignment7/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuth = false;
  @override
  void initState() {
    super.initState();
  }

  void checkForState() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    //if(sf.getString('uniqueKey')!=null)
  }

  @override
  Widget build(BuildContext context) {
    return (!isAuth) ? DashBoard() : SignUp();
  }
}
