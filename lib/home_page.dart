import 'dart:convert';

import 'package:codeware/model_class.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _idcontroler = TextEditingController();
  late List<dynamic> input1;
  late List<dynamic> input2;

  void initState() {
    super.initState();

    input1 = jsonDecode(
        '[{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]');
    input2 = jsonDecode(
        '[{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},{"0":{"id":8,"title":"Froyo"},"2":{"id":9,"title":"Éclair"},"3":{"id":10,"title":"Donut"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]');
  }

  List<AndroidVersion> _parseJson(List<dynamic> jsonList) {
    final List<AndroidVersion> androidVersions = [];

    for (final dynamic jsonObj in jsonList) {
      if (jsonObj is List<dynamic>) {
        for (final version in jsonObj) {
          androidVersions.add(AndroidVersion(
            id: version['id'],
            title: version['title'],
          ));
        }
      } else if (jsonObj is Map<String, dynamic>) {
        for (final version in jsonObj.values) {
          androidVersions.add(AndroidVersion(
            id: version['id'],
            title: version['title'],
          ));
        }
      }
    }

    return androidVersions;
  }

  AndroidVersion? _searchById(List<AndroidVersion> androidVersions, int id) {
    for (final version in androidVersions) {
      if (version.id == id) {
        return version;
      }
    }
    return null;
  }

  void _searchjson(List inte) {
    final List<AndroidVersion> androidVersions = _parseJson(inte);
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(inte == input1 ? "Json 1 Data" : "Json 2 Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final version in androidVersions)
              // ${version.id}:
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: ListTile(
                  tileColor: Colors.greenAccent,
                  title: Text('${version.title}'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _searchbyid(List inpu, int id) {
    final List<AndroidVersion> androidVersions = _parseJson(inpu);
    final AndroidVersion? foundVersion = _searchById(androidVersions, id);
    final String message =
        foundVersion == null ? 'ID not found!' : foundVersion.title!;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Title is'),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Code Ware'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Press a button to see the output:'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    _searchjson(input1);
                  },
                  child: Text('See json1'),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    _searchjson(input2);
                  },
                  child: Text('See json2'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10),
              child: TextFormField(
                controller: _idcontroler,
                decoration: InputDecoration(
                    hintText: "Search by Id", border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    _searchbyid(input1, int.parse("${_idcontroler.text}"));
                  },
                  child: Text('json1 Search By id'),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    _searchbyid(input2, int.parse("${_idcontroler.text}"));
                  },
                  child: Text('json2 Search By id'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
