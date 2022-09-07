import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String quote = "";
String author = "";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello world"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var url = Uri.parse(
              "https://goquotes-api.herokuapp.com/api/v1/random?count=1");
          var response = await http.get(url);

          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');

          var data = jsonDecode(response.body);
          print(response.body);
          print(data["quotes"][0]["text"]);
          print(data["quotes"][0]["author"]);

          quote = (data["quotes"][0]["text"]);
          author = (data["quotes"][0]["author"]);

          await Future.delayed(Duration(microseconds: 1500));

          setState(() {});
        },
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(quote),
                Text(author),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
