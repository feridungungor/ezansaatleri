import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/Screens/ilceler.dart';
import 'package:flutter_ezansaatleri/models/model_sehirler.dart';
import 'package:http/http.dart' as http;

class Sehirler extends StatelessWidget {
  String UlkeID;

  Sehirler({this.UlkeID});

  Future<List<ModelSehir>> SehirGetir() async {
    var response =
        await http.get("https://ezanvakti.herokuapp.com/sehirler/${UlkeID}");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => ModelSehir.fromJson(e))
          .toList();
    } else {
      throw Exception("gelmiyor!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sehirler"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SehirGetir(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ModelSehir>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ilceler(
                                  SehirID: snapshot.data[index].sehirId,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(snapshot.data[index].sehirAdi),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
