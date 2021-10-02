import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'log_in.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  static int pgNo = 0;
  List data = [];
  var scrollcontroller = new ScrollController();
  getData() async {
    int k = pgNo++;
    Uri url = Uri.parse("https://reqres.in/api/users?page=$k");

    final response = await http.get(url);
    Map<String, dynamic> map = json.decode(response.body);
    var decodedMsg = jsonDecode(response.body);
    print(decodedMsg);
    // ;
    setState(() {
      data = map['data'];
    });
    //print('--> ' + data.toString());
  }

  void initState() {
    super.initState();
    scrollcontroller..addListener(pagination);
    checkForData();
    getData();
  }

  String name = '', email = '', userName = '';

  void checkForData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? key = sf.getString('uniqueKey');
    List<String> keywords = key!.split('/');
    setState(() {
      name = keywords[2] + " " + keywords[3];
      email = keywords[4];
      userName = keywords[0];
    });
  }

  void pagination() async {
    if ((scrollcontroller.position.pixels >=
        scrollcontroller.position.maxScrollExtent * 0.7)) {
      print('@@@@@@@');
      //   isLoading = true;
      setState(() {
        pgNo += 1;
      });
      int pg = pgNo % 2 + 1;
      //add api for laod the more data according to new page
      Uri url = Uri.parse("https://reqres.in/api/users?page=$pg");

      final response = await http.get(url);
      Map<String, dynamic> map = json.decode(response.body);

      var decodedMsg = jsonDecode(response.body);
      print(decodedMsg);

      print('--> ' + data.toString());
      setState(() {
        data.addAll(map['data']);
      });
    } else {
      print('oooooooo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            child: ListView.builder(
                controller: scrollcontroller,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String fName = data[index]['first_name'];
                  String lName = data[index]['last_name'];
                  String emaile = data[index]['email'];
                  String id = data[index]['id'].toString();
                  return Card(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage(
                                      data[index]['avatar'].toString()),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    data[index]['first_name'] +
                                        " " +
                                        data[index]['last_name'],
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text(data[index]['email'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                child: Text("Edit"),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        String newFName = fName;
                                        String newLName = lName;
                                        String newEmail = emaile;
                                        return AlertDialog(
                                            title: Text("Edit User Details"),
                                            content: Container(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    initialValue: fName,
                                                    decoration: InputDecoration(
                                                      hintText: "First Name",
                                                    ),
                                                    onChanged: (v) {
                                                      newFName = v;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    initialValue: lName,
                                                    decoration: InputDecoration(
                                                      hintText: "Last Name",
                                                    ),
                                                    onChanged: (v) {
                                                      newLName = v;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    initialValue: emaile,
                                                    decoration: InputDecoration(
                                                      hintText: "Email",
                                                    ),
                                                    onChanged: (v) {
                                                      newEmail = v;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        editData(
                                                            newFName,
                                                            newLName,
                                                            newEmail,
                                                            id);
                                                        //   if (firstName != '' &&
                                                        //       lastName != '' &&
                                                        //       email != '' &&
                                                        //      ) {
                                                        //     registerUser(
                                                        //         firstName, lastName, userName, email, pwd, context);
                                                        //   }
                                                      },
                                                      child: Text("Submit")),
                                                ],
                                              ),
                                            ));
                                      });
                                },
                              )),
                          Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                child: Text("Delete"),
                                onPressed: () {},
                              ))
                        ],
                      ),
                    ),
                  );
                })),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text("Hi " + name)),
            ),
            ListTile(title: Text(email), onTap: () {}),
            ListTile(
              title: Text(userName),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LogIn()));
              },
            ),
          ],
        ),
      ),
    );
  }

  editData(String newFName, String newLName, String emaile, String id) async {
    Uri url = Uri.parse("https://reqres.in/api/users/$id");
    var body = json.encode(data);
    var response = await http.post(url,
        // headers: {"Content-Type": "application/json"},
        body: {"first_name": newFName, "last_name": newLName, 'email': emaile});

    return response;
  }
}
