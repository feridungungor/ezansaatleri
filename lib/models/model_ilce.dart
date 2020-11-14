// To parse this JSON data, do
//
//     final modelIlce = modelIlceFromJson(jsonString);

import 'dart:convert';

ModelIlce modelIlceFromJson(String str) => ModelIlce.fromJson(json.decode(str));

String modelIlceToJson(ModelIlce data) => json.encode(data.toJson());

class ModelIlce {
  ModelIlce({
    this.ilceAdi,
    this.ilceAdiEn,
    this.ilceId,
  });

  String ilceAdi;
  String ilceAdiEn;
  String ilceId;

  factory ModelIlce.fromJson(Map<String, dynamic> json) => ModelIlce(
    ilceAdi: json["IlceAdi"],
    ilceAdiEn: json["IlceAdiEn"],
    ilceId: json["IlceID"],
  );

  Map<String, dynamic> toJson() => {
    "IlceAdi": ilceAdi,
    "IlceAdiEn": ilceAdiEn,
    "IlceID": ilceId,
  };
}
