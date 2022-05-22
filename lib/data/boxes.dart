import 'package:hive/hive.dart';
import 'package:xnotes/models/note.dart';

class Boxes {
  static Box<Note> getNotes() => Hive.box('notes');
}
