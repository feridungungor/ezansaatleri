import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/models/model_vakitler.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Vakitler extends StatelessWidget {
  String ilceID;
  Vakitler({this.ilceID});

  Future<List<ModelVakitler>> vakitgetir() async {
    var response =
        await http.get("https://ezanvakti.herokuapp.com/vakitler/${ilceID}");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => ModelVakitler.fromJson(e))
          .toList();
    } else {
      print("dsşkgj");
    }
  }

  String getCurrentTime({ModelVakitler currentsnapshot}){
    String theTime;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    int sistremsaati = dakikagetir(formattedDate);
    if( sistremsaati>dakikagetir(currentsnapshot.aksam) && sistremsaati<=dakikagetir(currentsnapshot.yatsi)){
       theTime = currentsnapshot.yatsi+"/Yatsı";
    }
    else if( sistremsaati>dakikagetir(currentsnapshot.ikindi) && sistremsaati<=dakikagetir(currentsnapshot.aksam)){
      theTime = currentsnapshot.aksam+"/Aksam";
    }
    else if( sistremsaati>dakikagetir(currentsnapshot.ogle) && sistremsaati<=dakikagetir(currentsnapshot.ikindi)){
      theTime = currentsnapshot.ikindi+"/Ikindi";
    }
    else if( sistremsaati>dakikagetir(currentsnapshot.gunes) && sistremsaati<=dakikagetir(currentsnapshot.ogle)){
      theTime = currentsnapshot.ogle+"/Ogle";
    }
    else if( sistremsaati>dakikagetir(currentsnapshot.imsak) && sistremsaati<=dakikagetir(currentsnapshot.gunes)){
      theTime = currentsnapshot.gunes+"/Gunes";
    }
    else {
      theTime = currentsnapshot.imsak+"/Imsak";
    }
    return theTime;
  }

  int dakikagetir(String namazvakiti){
    int saat,dakika;
    saat = int.parse(namazvakiti.split(':')[0]);
    dakika = int.parse(namazvakiti.split(':')[1]);
    dakika += saat * 60;
    return dakika;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Vakitler"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: vakitgetir(),
        builder: (context, AsyncSnapshot<List<ModelVakitler>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Theme(
                  data: ThemeData(
                    accentColor: Colors.black
                  ),
                  child: ExpansionTile(
                  backgroundColor: Colors.black12,

                    title: Text(snapshot.data[index].miladiTarihUzun,style: TextStyle(color: Colors.black),),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            index == 0 ? KalanZaman(getCurrentTime(currentsnapshot: snapshot.data[0])) : Text(
                              snapshot.data[index].aksam,
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                            Column(
                              children: [
                                Image.network(snapshot.data[index].ayinSekliUrl),
                                Text(snapshot.data[index].hicriTarihUzun)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ezanvaktiezansaati(
                                "İmsak", snapshot.data[index].imsak),
                            ezanvaktiezansaati(
                                "Güneş", snapshot.data[index].gunes),
                            ezanvaktiezansaati("Öğle", snapshot.data[index].ogle),
                            ezanvaktiezansaati(
                                "İkindi", snapshot.data[index].ikindi),
                            ezanvaktiezansaati(
                                "Akşam", snapshot.data[index].aksam),
                            ezanvaktiezansaati(
                                "Yatsı", snapshot.data[index].yatsi),
                          ],
                        ),
                      ),
                    ],
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

  Widget ezanvaktiezansaati(String ezanvakti, String ezansaati) {
    return Column(
      children: [
        Text(ezanvakti),
        Text(ezansaati),
      ],
    );
  }

  Widget KalanZaman(String kalanzaman){
    print(kalanzaman);
    return Column(
      children: [
        Text("Yaklaşan Vakit"),
        Row(
          children: [
            Text(kalanzaman.split('/')[1]),
            SizedBox(width: 10,),
            Text(kalanzaman.split('/')[0])
          ],
        )
      ],
    );
  }
}
