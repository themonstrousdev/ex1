import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class ImageModel {
  int id;
  String url, title;

  ImageModel(this.id, this.url, this.title);

  ImageModel.fromJson(Map<String, dynamic> parsed) {
    id = parsed['id'];
    url = parsed['url'];
    title = parsed['title'];
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int ctr = 0;
  List<Widget> images = [];

  void fetchImage() async {
    ctr++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$ctr');
    var model = ImageModel.fromJson(json.decode(response.body));

    images.add(
      Column(
        children: <Widget>[
          Image(image: NetworkImage(model.url)),
          Text(model.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        ],
      )
    );

    images.add(SizedBox(height: 20));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Let\'s See Images'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: images,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              fetchImage();
            });
          },
          tooltip: 'Add New Image',
          child: Icon(Icons.add),
        ),
      )
    );
  }
}