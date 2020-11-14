// To parse this JSON data, do
//
//     final modelSehir = modelSehirFromJson(jsonString);

import 'dart:convert';

ModelSehir modelSehirFromJson(String str) => ModelSehir.fromJson(json.decode(str));

String modelSehirToJson(ModelSehir data) => json.encode(data.toJson());

class ModelSehir {
  ModelSehir({
    this.sehirAdi,
    this.sehirAdiEn,
    this.sehirId,
  });

  String sehirAdi;
  String sehirAdiEn;
  String sehirId;

  factory ModelSehir.fromJson(Map<String, dynamic> json) => ModelSehir(
    sehirAdi: json["SehirAdi"],
    sehirAdiEn: json["SehirAdiEn"],
    sehirId: json["SehirID"],
  );

  Map<String, dynamic> toJson() => {
    "SehirAdi": sehirAdi,
    "SehirAdiEn": sehirAdiEn,
    "SehirID": sehirId,
  };
}
