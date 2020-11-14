import 'dart:convert';

ModelVakitler modelVakitlerFromJson(String str) => ModelVakitler.fromJson(json.decode(str));

String modelVakitlerToJson(ModelVakitler data) => json.encode(data.toJson());

class ModelVakitler {
  ModelVakitler({
    this.aksam,
    this.ayinSekliUrl,
    this.gunes,
    this.gunesBatis,
    this.gunesDogus,
    this.hicriTarihKisa,
    this.hicriTarihKisaIso8601,
    this.hicriTarihUzun,
    this.hicriTarihUzunIso8601,
    this.ikindi,
    this.imsak,
    this.kibleSaati,
    this.miladiTarihKisa,
    this.miladiTarihKisaIso8601,
    this.miladiTarihUzun,
    this.miladiTarihUzunIso8601,
    this.ogle,
    this.yatsi,
  });

  String aksam;
  String ayinSekliUrl;
  String gunes;
  String gunesBatis;
  String gunesDogus;
  String hicriTarihKisa;
  dynamic hicriTarihKisaIso8601;
  String hicriTarihUzun;
  dynamic hicriTarihUzunIso8601;
  String ikindi;
  String imsak;
  String kibleSaati;
  String miladiTarihKisa;
  String miladiTarihKisaIso8601;
  String miladiTarihUzun;
  DateTime miladiTarihUzunIso8601;
  String ogle;
  String yatsi;

  factory ModelVakitler.fromJson(Map<String, dynamic> json) => ModelVakitler(
    aksam: json["Aksam"],
    ayinSekliUrl: json["AyinSekliURL"],
    gunes: json["Gunes"],
    gunesBatis: json["GunesBatis"],
    gunesDogus: json["GunesDogus"],
    hicriTarihKisa: json["HicriTarihKisa"],
    hicriTarihKisaIso8601: json["HicriTarihKisaIso8601"],
    hicriTarihUzun: json["HicriTarihUzun"],
    hicriTarihUzunIso8601: json["HicriTarihUzunIso8601"],
    ikindi: json["Ikindi"],
    imsak: json["Imsak"],
    kibleSaati: json["KibleSaati"],
    miladiTarihKisa: json["MiladiTarihKisa"],
    miladiTarihKisaIso8601: json["MiladiTarihKisaIso8601"],
    miladiTarihUzun: json["MiladiTarihUzun"],
    miladiTarihUzunIso8601: DateTime.parse(json["MiladiTarihUzunIso8601"]),
    ogle: json["Ogle"],
    yatsi: json["Yatsi"],
  );

  Map<String, dynamic> toJson() => {
    "Aksam": aksam,
    "AyinSekliURL": ayinSekliUrl,
    "Gunes": gunes,
    "GunesBatis": gunesBatis,
    "GunesDogus": gunesDogus,
    "HicriTarihKisa": hicriTarihKisa,
    "HicriTarihKisaIso8601": hicriTarihKisaIso8601,
    "HicriTarihUzun": hicriTarihUzun,
    "HicriTarihUzunIso8601": hicriTarihUzunIso8601,
    "Ikindi": ikindi,
    "Imsak": imsak,
    "KibleSaati": kibleSaati,
    "MiladiTarihKisa": miladiTarihKisa,
    "MiladiTarihKisaIso8601": miladiTarihKisaIso8601,
    "MiladiTarihUzun": miladiTarihUzun,
    "MiladiTarihUzunIso8601": miladiTarihUzunIso8601.toIso8601String(),
    "Ogle": ogle,
    "Yatsi": yatsi,
  };
}
