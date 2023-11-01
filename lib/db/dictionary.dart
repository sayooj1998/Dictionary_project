import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'dictionary.g.dart';

@HiveType(typeId: 0)
class MyData {
  @HiveField(0)
  var id;

  @HiveField(1)
  String english_word;

  @HiveField(2)
  String part_of_speech;

  @HiveField(3)
  String malayalam_definition;

  MyData(
      {required this.id,
      required this.english_word,
      required this.part_of_speech,
      required this.malayalam_definition});
}
