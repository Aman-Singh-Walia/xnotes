import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:xnotes/data/boxes.dart';
import 'package:xnotes/models/note.dart';
import 'package:xnotes/widgets/note_tile.dart';

class FavoriteNotes extends StatefulWidget {
  const FavoriteNotes({Key? key}) : super(key: key);

  @override
  _FavoriteNotesState createState() => _FavoriteNotesState();
}

class _FavoriteNotesState extends State<FavoriteNotes> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Note>>(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, box, _) {
          final favoriteNotes = box.values
              .where((element) => element.favorite)
              .toList()
              .cast<Note>();

          return favoriteNotes.isEmpty
              ? Center(
                  child: Text(
                    'No Favorites',
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
                  children:
                      favoriteNotes.map((e) => NoteTile(note: e)).toList(),
                );
        });
  }
}
