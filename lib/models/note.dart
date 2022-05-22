import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime date;

  @HiveField(2)
  late bool favorite;

  @HiveField(3)
  late int color;

  @HiveField(4)
  late int txtColor;

  @HiveField(5)
  late List<dynamic> content;
}
