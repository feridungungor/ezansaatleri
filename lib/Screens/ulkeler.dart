import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/Screens/sehirler.dart';
import 'package:flutter_ezansaatleri/models/model_ulke.dart';
import 'package:flutter_ezansaatleri/tool/search.dart';
import 'package:http/http.dart' as http;

class Ulkeler extends StatelessWidget {

  List<ModelUlke> ulkeler;

  Future<List<ModelUlke>> Ulkegetir() async {
    var response = await http.get("https://ezanvakti.herokuapp.com/ulkeler");
    if (response.statusCode == 200) {

      ulkeler = (json.decode(response.body) as List)
          .map((e) => ModelUlke.fromJson(e))
          .toList();

      return (json.decode(response.body) as List)
          .map((e) => ModelUlke.fromJson(e))
          .toList();
    } else {
      throw Exception("Hata var");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: (){
                showSearch(context: context, delegate: DataSearch(ulkeler: ulkeler));
              },
              child: Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: Icon(Icons.search),
              ),
            )
          ],
          backgroundColor: Colors.grey,
          title: Text("Ulkeler"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Ulkegetir(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ModelUlke>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Sehirler(
                                  UlkeID: snapshot.data[index].ulkeId)));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(snapshot.data[index].ulkeAdi),
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
        ));
  }
}
