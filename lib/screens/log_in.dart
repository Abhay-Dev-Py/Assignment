import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String userName = '', pwd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Center(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "userName",
                  ),
                  onChanged: (v) {
                    userName = v;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: " Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (v) {
                    pwd = v;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (userName != '' && pwd != '') {
                        loginUser(userName, pwd, context);
                      }
                    },
                    child: Text("Log IN"))
              ],
            ),
          )),
        ),
      ),
    );
  }
}

void loginUser(String userName, String pwd, BuildContext context) async {
  SharedPreferences user = await SharedPreferences.getInstance();

  List<String> keywords = [];
  if (user.getString("uniqueKey") == null) {
    // nav to register screen
  } else {
    String key = user.getString('uniqueKey').toString();
    keywords = key.split('/');
    String genKey = userName + pwd;
    String actualKey = keywords[0] + keywords[1];
    if (genKey == actualKey) {
      //Nav to dashboard
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashBoard()));
    } else {
      //Show error msg. Nav back to login
    }
  }
}
