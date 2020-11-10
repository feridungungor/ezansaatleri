import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/Screens/vakitler.dart';
import 'package:flutter_ezansaatleri/models/model_ilce.dart';
import 'package:http/http.dart' as http;

class Ilceler extends StatelessWidget {
  String SehirID;

  Ilceler({this.SehirID});

  Future<List<ModelIlce>> ilcegetir() async {
    var response = await http.get(
        "https://ezanvakti.herokuapp.com/ilceler/${SehirID}");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((e) =>
          ModelIlce.fromJson(e)).toList();
    } else {
      print("dedik geçtik");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İlçeler"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ilcegetir(),
        builder: (context, AsyncSnapshot<List<ModelIlce>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            Vakitler(ilceID: snapshot.data[index].ilceId,)));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(snapshot.data[index].ilceAdi),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
