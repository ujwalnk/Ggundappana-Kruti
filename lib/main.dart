import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gundappana_kruti/gen/json2hive.dart';
import 'package:gundappana_kruti/screens/kagga.dart';
import 'package:gundappana_kruti/services/shared_pref.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gundappana_kruti/model/data.dart';

// Hive Model
import 'package:hive/hive.dart';

// Screens
import 'package:gundappana_kruti/screens/home.dart';

void main() async {

  // Wait for the application Init
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPreferencesManager().init();

  // Get the path to Hive DB
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  debugPrint(directory.path);
  Hive.registerAdapter(ModelAdapter());

  // Open Hive Box
  // await Hive.openBox('hive_box');

  await Hive.initFlutter();
  final bytesDatabase = await rootBundle.load('assets/database/hive_box.hive');
  await Hive.openBox<Model>('hive_box', bytes: bytesDatabase.buffer.asUint8List());
  

  // await run();



  runApp(
    MaterialApp(
        initialRoute: "/home",
        routes: {
          "/home": (context) => const HomePage(),
          "/kagga": (context) => const KaggaScreen(),
        },
        theme: ThemeData(
          primaryColor: Colors.purpleAccent,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system),
  );
}
