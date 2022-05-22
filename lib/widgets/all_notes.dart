import 'package:flutter/material.dart';
import 'package:xnotes/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xnotes/widgets/note_tile.dart';
import '../data/boxes.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({Key? key}) : super(key: key);

  @override
  _AllNotesState createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Note>>(
      valueListenable: Boxes.getNotes().listenable(),
      builder: ((context, box, _) {
        final allNotes = box.values.toList().cast<Note>();
        return allNotes.isEmpty
            ? Center(
                child: Text(
                  'No Notes',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              )
            : GridView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                children: allNotes.map((e) => NoteTile(note: e)).toList(),
              );
      }),
    );
  }
}
