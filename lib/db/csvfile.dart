import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:csv/csv.dart';
import 'dictionary.dart';

Future<void> uploadCSVToHive() async {
  try {
    final String csvText = await rootBundle.loadString('assets/olam.csv');

    final List<List<dynamic>> csvList = CsvToListConverter().convert(csvText);
    final myDataBox = await Hive.openBox<MyData>('my_data');

    for (int element = 0; element < csvList.length; element++) {
      final myModel = MyData(
        id: csvList[element][0].toString(),
        english_word: csvList[element][1].toString().toLowerCase(),
        part_of_speech: csvList[element][2].toString().toLowerCase(),
        malayalam_definition: csvList[element][3].toString().toLowerCase(),
      );

      myDataBox.add(myModel);
    }
  } catch (e) {
    print(e);
  }
}
