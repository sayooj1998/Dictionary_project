import 'package:dictionary_project/db/dictionary.dart';
import 'package:hive/hive.dart';

Future<List<MyData>> searchWordMalayalam(
    String searchController, String searchType) async {
  final myDataBox = await Hive.openBox<MyData>('my_data');
  //var searchList = myDataBox.values.toList();
  print(searchController);
  List<MyData> foundItemList = [];

  RegExp regExpStart = RegExp(
    '^$searchController',
    caseSensitive: false,
  );
  RegExp regExpEndWith = RegExp(
    '$searchController\$',
    caseSensitive: false,
  );

  List<MyData> meaningWord = myDataBox.values.toList();

  switch (searchType) {
    case 'start':
      foundItemList = meaningWord
          .where((word) => regExpStart.hasMatch(word.malayalam_definition))
          .toList();

    case "contains":
      int idx = 0;
      while (idx < meaningWord.length) {
        if (meaningWord[idx].malayalam_definition.contains(searchController)) {
          foundItemList.add(meaningWord[idx]);
        }

        idx++;
      }
      print(searchType);
    case "end":
      int idx = 0;
      while (idx < meaningWord.length && searchType.toString() != '') {
        if (regExpEndWith.hasMatch(meaningWord[idx].malayalam_definition)) {
          foundItemList.add(meaningWord[idx]);
        }

        idx++;
      }
  }

  return foundItemList;
}
