import 'package:dictionary_project/db/csvfile.dart';
import 'package:dictionary_project/pages/bottomnavbar.dart';
import 'package:dictionary_project/pages/history.dart';
import 'package:dictionary_project/pages/home.dart';
import 'package:dictionary_project/db/searchworld.dart';
import 'package:dictionary_project/pages/malayalamsearch/malayalam.dart';
import 'package:dictionary_project/pages/malayalamsearch/malayalamhistory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/dictionary.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MyDataAdapter().typeId)) {
    Hive.registerAdapter(MyDataAdapter());
  }

  await Hive.openBox<MyData>('my_data');
  uploadCSVToHive();

  runApp((GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => home(),
        '/malayalamsearch': (context) => malayalamsearch(),
        '/history': (context) => popup(
              history: [],
            ),
        '/historyMalayalam': (context) => popupMalayalam(historyMalayalam: [])
      })));
}
