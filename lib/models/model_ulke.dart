// To parse this JSON data, do
//
//     final modelUlke = modelUlkeFromJson(jsonString);

import 'dart:convert';

ModelUlke modelUlkeFromJson(String str) => ModelUlke.fromJson(json.decode(str));

String modelUlkeToJson(ModelUlke data) => json.encode(data.toJson());

class ModelUlke {
  ModelUlke({
    this.ulkeAdi,
    this.ulkeAdiEn,
    this.ulkeId,
  });

  String ulkeAdi;
  String ulkeAdiEn;
  String ulkeId;

  factory ModelUlke.fromJson(Map<String, dynamic> json) => ModelUlke(
    ulkeAdi: json["UlkeAdi"],
    ulkeAdiEn: json["UlkeAdiEn"],
    ulkeId: json["UlkeID"],
  );

  Map<String, dynamic> toJson() => {
    "UlkeAdi": ulkeAdi,
    "UlkeAdiEn": ulkeAdiEn,
    "UlkeID": ulkeId,
  };
}
