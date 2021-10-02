import 'package:assignment7/screens/dashboard.dart';
import 'package:assignment7/screens/log_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String firstName = "",
      lastName = "",
      userName = "",
      email = "",
      pwd = "",
      cnfPwd = "";

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
                    hintText: "First Name",
                  ),
                  onChanged: (v) {
                    firstName = v;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                  onChanged: (v) {
                    lastName = v;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "User Name",
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
                    hintText: "Email",
                  ),
                  onChanged: (v) {
                    email = v;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onChanged: (v) {
                    pwd = v;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: " Confirm Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (v) {
                    cnfPwd = v;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (firstName != '' &&
                          lastName != '' &&
                          email != '' &&
                          userName != '' &&
                          pwd != '' &&
                          cnfPwd != '') {
                        registerUser(
                            firstName, lastName, userName, email, pwd, context);
                      }
                    },
                    child: Text("Sign UP")),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text("LoginPage"))
              ],
            ),
          )),
        ),
      ),
    );
  }

  void registerUser(String firstName, String lastName, String userName,
      String email, String pwd, BuildContext context) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    if (user.getString("uniqueKey") == null) {
      String uniqueKey =
          userName + "/" + pwd + "/" + firstName + "/" + lastName + "/" + email;
      user.setString("uniqueKey", uniqueKey);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogIn()));
    }
  }
}
