import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gundappana_kruti/model/data.dart';
import 'package:hive/hive.dart';

class Kagga{
  final String id;
  final String kaggaKannada;
  final String kaggaEnglish;
  final String meaningKannada;
  final String meaningEnglish;
  final String vyakhyana;
  final String tatparya;

  Kagga({required this.id, required this.kaggaKannada, required this.kaggaEnglish, required this.meaningKannada, required this.meaningEnglish, required this.vyakhyana, required this.tatparya});

}

Future<List> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  var map = jsonDecode(input);
  // return map['kagga'];
  debugPrint(map[1].toString());
  return map;
}

Future run() async{
  debugPrint("Run function call");

  List dataList = await readJsonFile("assets/database/mankutimma.json");
  debugPrint("Got dataList");
  final box = await Hive.openBox("hive_box");

  debugPrint("Having ${dataList.length} kaggas");

  for (var element in dataList) {
    debugPrint(element["_id"].toString());
    Model m = Model("${element['_id'].toString()}_mk", element["kagga_kn"]);
    m.kaggaEnglish = element["kagga_latn"];
    m.meaningKannada = element["kagga_meaning_kn"];
    m.meaningEnglish = element["kagga_eng"];
    m.tatparya = element["kagga_tatparya_kn"];
    m.vyakhyana = element["kagga_vyakhyana_kn"];

    box.add(m);

    // return;
  }

  debugPrint("Written to Hive");
}