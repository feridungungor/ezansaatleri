import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/models/model_vakitler.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:countdown_flutter/countdown_flutter.dart';

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

  String getCurrentTime({ModelVakitler currentsnapshot}) {
    String theTime;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    int sistremsaati = dakikagetir(formattedDate);
    if (sistremsaati > dakikagetir(currentsnapshot.aksam) &&
        sistremsaati <= dakikagetir(currentsnapshot.yatsi)) {
      theTime = currentsnapshot.yatsi + "/Yatsı";
    } else if (sistremsaati > dakikagetir(currentsnapshot.ikindi) &&
        sistremsaati <= dakikagetir(currentsnapshot.aksam)) {
      theTime = currentsnapshot.aksam + "/Aksam";
    } else if (sistremsaati > dakikagetir(currentsnapshot.ogle) &&
        sistremsaati <= dakikagetir(currentsnapshot.ikindi)) {
      theTime = currentsnapshot.ikindi + "/Ikindi";
    } else if (sistremsaati > dakikagetir(currentsnapshot.gunes) &&
        sistremsaati <= dakikagetir(currentsnapshot.ogle)) {
      theTime = currentsnapshot.ogle + "/Ogle";
    } else if (sistremsaati > dakikagetir(currentsnapshot.imsak) &&
        sistremsaati <= dakikagetir(currentsnapshot.gunes)) {
      theTime = currentsnapshot.gunes + "/Gunes";
    } else {
      theTime = currentsnapshot.imsak + "/Imsak";
    }
    return theTime;
  }

  int dakikagetir(String namazvakiti) {
    int saat, dakika;
    saat = int.parse(namazvakiti.split(':')[0]);
    dakika = int.parse(namazvakiti.split(':')[1]);
    dakika += saat * 60;
    return dakika;
  }

  int dakikafarki(String yaklasanvakit) {
    int dakikayaklasanvakit = dakikagetir(yaklasanvakit.split('/')[0]);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    int dakikaformattedDate = dakikagetir(formattedDate);
    return dakikayaklasanvakit - dakikaformattedDate;
  }

  bool boolyaklasanvakit(String yaklasanvaki,String gelen){
    print("${yaklasanvaki} ### ${gelen}");

    if(yaklasanvaki.split('/')[1]==gelen){
      return true;
    }else{
      return false;
    }
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
                  data: ThemeData(accentColor: Colors.black),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    backgroundColor: Colors.black12,
                    title: Text(
                      snapshot.data[index].miladiTarihUzun,
                      style: TextStyle(color: Colors.black),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                index == 0
                                    ? Text(
                                  "Kalan Süre",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )
                                    : Text(
                                  snapshot.data[index].aksam,
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                index == 0
                                    ? CountdownFormatted(
                                  duration: Duration(
                                      minutes: dakikafarki(getCurrentTime(
                                          currentsnapshot:
                                          snapshot.data[0]))),
                                  builder: (BuildContext ctx,
                                      String remaining) {
                                    return Text(
                                      remaining,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ); // 01:00:00
                                  },
                                )
                                    : Text("")
                              ],
                            ),
                            Column(
                              children: [
                                Image.network(
                                    snapshot.data[index].ayinSekliUrl),
                                Text(snapshot.data[index].hicriTarihUzun),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: index == 0 ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ezanvaktiezansaati(
                                "İmsak", snapshot.data[index].imsak, boolyaklasanvakit(getCurrentTime(
                                currentsnapshot:
                                snapshot.data[0]),"İmsak")),
                            ezanvaktiezansaati(
                                "Güneş", snapshot.data[index].gunes, boolyaklasanvakit(getCurrentTime(
                                currentsnapshot:
                                snapshot.data[0]),"Güneş")),
                            ezanvaktiezansaati(
                                "Öğle", snapshot.data[index].ogle, boolyaklasanvakit(getCurrentTime(
                                currentsnapshot:
                                snapshot.data[0]),"Öğle")),
                            ezanvaktiezansaati(
                                "İkindi", snapshot.data[index].ikindi, boolyaklasanvakit(getCurrentTime(
                                currentsnapshot:
                                snapshot.data[0]),"İkindi")),
                            ezanvaktiezansaati(
                                "Akşam", snapshot.data[index].aksam, boolyaklasanvakit(getCurrentTime(
                                currentsnapshot:
                                snapshot.data[0]),"Aksam")),
                            ezanvaktiezansaati(
                                "Yatsı", snapshot.data[index].yatsi, boolyaklasanvakit(getCurrentTime(
                                currentsnapshot:
                                snapshot.data[0]),"Yatsı")),
                          ],
                        ) :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ezanvaktiezansaati(
                                "İmsak", snapshot.data[index].imsak, false),
                            ezanvaktiezansaati(
                                "Güneş", snapshot.data[index].gunes, false),
                            ezanvaktiezansaati(
                                "Öğle", snapshot.data[index].ogle, false),
                            ezanvaktiezansaati(
                                "İkindi", snapshot.data[index].ikindi, false),
                            ezanvaktiezansaati(
                                "Akşam", snapshot.data[index].aksam, false),
                            ezanvaktiezansaati(
                                "Yatsı", snapshot.data[index].yatsi, false),
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

  Widget ezanvaktiezansaati(String ezanvakti, String ezansaati, bool value) {
    return Column(
      children: [
        Text(ezanvakti,style: value
            ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18)
            : TextStyle(color: Colors.black,),),
        Text(
          ezansaati,
          style: value
              ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18)
              : TextStyle(color: Colors.black,),
        ),
      ],
    );
  }

  Widget KalanZaman(String kalanzaman) {
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