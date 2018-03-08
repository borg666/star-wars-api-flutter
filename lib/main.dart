import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StarWarsData extends StatefulWidget {
  @override
  StarWarsState createState() => new StarWarsState();
}

void main() {
  MaterialApp materialApp = new MaterialApp(home: new StarWarsData());
  runApp(materialApp);
}

class StarWarsState extends State<StarWarsData> {
  final String url = "https://swapi.co/api/starships";
  List data;

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });

    return "Success!";
  }

  Widget build(BuildContext context) {
    Text text = new Text("Stars Starship");
    AppBar appBar =
        new AppBar(title: text, backgroundColor: Colors.amberAccent);

    ListView listView = new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        List<Widget> widgets = [
          createCard(index, "name"),
          createCard(index, "model")
        ];
        Column column = new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: widgets);
        Container container = new Container(child: column);

        return new Center(child: container);
      },
    );

    return new Scaffold(
      appBar: appBar,
      body: listView,
    );
  }

  void initState() {
    super.initState();
    this.getSWData();
  }

  Card createCard(int index, String key) {
    TextStyle textStyle = new TextStyle(fontSize: 18.0, color: Colors.black54);
    Text nameText = new Text(data[index][key], style: textStyle);
    Container container =
        new Container(padding: new EdgeInsets.all(15.0), child: nameText);
    return new Card(child: container);
  }
}
