import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/models/model_vakitler.dart';
import 'package:http/http.dart' as http;
class Vakitler extends StatelessWidget {
  String ilceID;
  Vakitler({this.ilceID});

  Future<List<ModelVakitler>> vakitgetir()async{
    var response = await http.get("https://ezanvakti.herokuapp.com/vakitler/${ilceID}");
    if(response.statusCode == 200){
      return (json.decode(response.body) as List).map((e) => ModelVakitler.fromJson(e)).toList();
    }else{
      print("dsşkgj");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vakitler"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: vakitgetir(),
        builder: (context,AsyncSnapshot<List<ModelVakitler>> snapshot){
          if(snapshot.hasData){
            return Container(
              height:  100,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ezanvakitrow("Imsak",snapshot.data[0].imsak),
                      ezanvakitrow("Güneş",snapshot.data[0].gunes),
                      ezanvakitrow("Öğle",snapshot.data[0].ogle),
                      ezanvakitrow("İkindi",snapshot.data[0].ikindi),
                      ezanvakitrow("Akşam",snapshot.data[0].aksam),
                      ezanvakitrow("Yatsı",snapshot.data[0].yatsi),
                    ],
                  ),
                  Image.network(snapshot.data[0].ayinSekliUrl)
                ],
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget ezanvakitrow(String vakitismi, String vakitsaati){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${vakitismi}: ",textAlign: TextAlign.start,style: TextStyle(color: Colors.white),),
        SizedBox(width: 10,),
        Text(vakitsaati,style: TextStyle(color: Colors.white),)
      ],
    );
  }
}
