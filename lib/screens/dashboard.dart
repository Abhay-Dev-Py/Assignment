import 'dart:convert';

import 'package:assignment7/screens/user_details_page.dart';
import 'package:assignment7/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

    getData();
  }

  String name = '', email = '', userName = '';

  void pagination() async {
    if ((scrollcontroller.position.pixels >=
        scrollcontroller.position.maxScrollExtent * 0.7)) {
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
                  String sourceImageAvatar = data[index]['avatar'].toString();
                  return InkWell(
                    onTap: () {
                      //Redirect to details page
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return UserDetails(id: id);
                      }));
                    },
                    child: InfoCard(
                        fName: fName,
                        lName: lName,
                        emaile: emaile,
                        id: id,
                        sourceImageAvatar: sourceImageAvatar),
                  );
                })),
      ),
    );
  }
}
