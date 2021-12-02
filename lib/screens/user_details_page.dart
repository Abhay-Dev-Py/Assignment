import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  String id;
  UserDetails({required this.id});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  dynamic data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call for api here.
    getData();
  }

  getData() async {
    Uri url = Uri.parse("https://reqres.in/api/users?${widget.id}");

    final response = await http.get(url);
    Map<String, dynamic> map = json.decode(response.body);
    var decodedMsg = jsonDecode(response.body);

    setState(() {
      data = map['data'];
    });
    print('--> ' + data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              //Image Widget,
              Expanded(
                flex: 3,
                child: CircleAvatar(
                  radius: 155,
                  backgroundImage: NetworkImage(data[0]['avatar'].toString()),
                ),
              ),
              //Name,
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                      data[0]['first_name'] + " " + data[0]['last_name'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              //Mail,
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    print('Sent a mail to -> ' + data[0]['email'].toString());
                  },
                  child: Column(
                    children: [
                      Text(data[0]['email'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              textBaseline: TextBaseline.alphabetic)),
                      Text(
                        'Click Me',
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              //Click me to mail me!!,
            ],
          ),
        ),
      ),
    );
  }
}
