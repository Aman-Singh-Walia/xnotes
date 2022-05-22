import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:xnotes/animations/page_transition.dart';
import 'package:xnotes/models/note.dart';
import 'package:xnotes/pages/edit_workspace.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
        onPressed: () {
          goToEditWorkspace(context, widget.note);
        },
        menuOffset: 5.0,
        menuWidth: MediaQuery.of(context).size.width * 0.45,
        blurSize: 2.0,
        blurBackgroundColor: Colors.transparent,
        menuBoxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(widget.note.color),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black12, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.title,
                softWrap: true,
                maxLines: 5,
                style: TextStyle(
                    color: Color(widget.note.txtColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.note.date.day}-${widget.note.date.month}-${widget.note.date.year}',
                    style: TextStyle(
                        color: Color(widget.note.txtColor),
                        fontFamily: 'Varela'),
                  ),
                  Visibility(
                    visible: widget.note.favorite,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[100]),
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        size: 20.0,
                        color: CupertinoColors.systemPink,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        menuItems: [
          FocusedMenuItem(
            onPressed: () {
              toggleFavorite(widget.note);
            },
            backgroundColor: Colors.transparent,
            trailingIcon: Icon(
              widget.note.favorite
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart,
              color: widget.note.favorite
                  ? CupertinoColors.systemPink
                  : Colors.black,
            ),
            title: Text(
              widget.note.favorite ? 'Remove' : 'Favorite',
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          FocusedMenuItem(
            onPressed: () {
              deleteNote(widget.note);
            },
            backgroundColor: Colors.transparent,
            trailingIcon: const Icon(
              CupertinoIcons.delete,
              color: Colors.black,
            ),
            title: const Text(
              'Delete',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]);
  }

  void toggleFavorite(Note n) {
    if (widget.note.favorite) {
      n.favorite = false;
      n.save();
    } else if (!widget.note.favorite) {
      n.favorite = true;
      n.save();
    }
  }

  void deleteNote(Note n) {
    n.delete();
  }

  //delete note
  void goToEditWorkspace(context, Note n) {
    Navigator.of(context).push(CustomPageRoute(
        child: EditWorkspace(
      currentNote: n,
    )));
  } //delete note

}
