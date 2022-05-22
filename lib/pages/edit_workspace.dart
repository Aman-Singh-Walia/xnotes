import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'package:xnotes/models/note.dart';

import 'package:xnotes/widgets/tile_color_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class EditWorkspace extends StatefulWidget {
  final Note currentNote;
  const EditWorkspace({Key? key, required this.currentNote}) : super(key: key);

  @override
  _EditWorkspaceState createState() => _EditWorkspaceState();
}

class _EditWorkspaceState extends State<EditWorkspace> {
  String noteTileCurrentColor = 'default';
  bool readerMode = true;
  TextEditingController titleController = TextEditingController();
  QuillController quillController = QuillController.basic();
  int colorSelection = 0xFFFFFFFF;
  int txtColorSelection = 0xFF424242;

  @override
  Widget build(BuildContext context) {
    colorSelection = widget.currentNote.color;
    txtColorSelection = widget.currentNote.txtColor;
    titleController.text = widget.currentNote.title;
    quillController = QuillController(
        document: Document.fromJson(widget.currentNote.content),
        selection: const TextSelection.collapsed(offset: 0));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                var json =
                    jsonEncode(quillController.document.toDelta().toJson());
                setState(() {
                  widget.currentNote.title = titleController.text;
                  widget.currentNote.content = jsonDecode(json);
                  widget.currentNote.color = colorSelection;
                  widget.currentNote.txtColor = txtColorSelection;
                  !readerMode ? readerMode = true : readerMode = false;
                });
              },
              icon: Icon(!readerMode
                  ? CupertinoIcons.book
                  : CupertinoIcons.book_fill)),
          PopupMenuButton(
              enabled: readerMode ? false : true,
              icon: const Icon(CupertinoIcons.paintbrush),
              elevation: 1.0,
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFFFFFFFF;
                          txtColorSelection = 0xFF424242;
                        },
                        child: TileColorItem(
                          name: 'Default',
                          tileColor: 0xFFFFFFFF,
                          selected: colorSelection == 0xFFFFFFFF ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFF0E0D0D;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Black',
                          tileColor: 0xFF0E0D0D,
                          selected: colorSelection == 0xFF0E0D0D ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFFD32F2F;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Red',
                          tileColor: 0xFFD32F2F,
                          selected: colorSelection == 0xFFD32F2F ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFF4CAF50;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Green',
                          tileColor: 0xFF4CAF50,
                          selected: colorSelection == 0xFF4CAF50 ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFFFFEB3B;
                          txtColorSelection = 0xFF424242;
                        },
                        child: TileColorItem(
                          name: 'Yellow',
                          tileColor: 0xFFFFEB3B,
                          selected: colorSelection == 0xFFFFEB3B ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFFFF4081;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Pink',
                          tileColor: 0xFFFF4081,
                          selected: colorSelection == 0xFFFF4081 ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFF1976D2;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Blue',
                          tileColor: 0xFF1976D2,
                          selected: colorSelection == 0xFF1976D2 ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFF009688;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Teal',
                          tileColor: 0xFF009688,
                          selected: colorSelection == 0xFF009688 ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFFFF5722;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Orange',
                          tileColor: 0xFFFF5722,
                          selected: colorSelection == 0xFFFF5722 ? true : false,
                        )),
                    PopupMenuItem(
                        onTap: () {
                          colorSelection = 0xFF9C27B0;
                          txtColorSelection = 0xFFFFFFFF;
                        },
                        child: TileColorItem(
                          name: 'Purple',
                          tileColor: 0xFF9C27B0,
                          selected: colorSelection == 0xFF9C27B0 ? true : false,
                        )),
                  ]),
          IconButton(
              onPressed: readerMode
                  ? null
                  : () {
                      var json = jsonEncode(
                          quillController.document.toDelta().toJson());
                      editNote(
                          widget.currentNote,
                          titleController.text == ''
                              ? 'Note'
                              : titleController.text,
                          colorSelection,
                          txtColorSelection,
                          jsonDecode(json));
                      showSnackMsg('Updated!', context);
                    },
              icon: const Icon(CupertinoIcons.checkmark_alt))
        ],
        bottom: PreferredSize(
            child: Container(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                width: double.infinity,
                child: TextField(
                  readOnly: readerMode,
                  controller: titleController,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Title Here',
                    border: InputBorder.none,
                  ),
                )),
            preferredSize: const Size.fromHeight(25.0)),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: QuillEditor.basic(
                      controller: quillController, readOnly: readerMode))),
          Visibility(
            visible: !readerMode ? true : false,
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.black12, width: 1.0))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: QuillToolbar.basic(
                  onImagePickCallback: _onImagePickCallback,
                  onVideoPickCallback: _onVideoPickCallback,
                  controller: quillController,
                  toolbarIconSize: 25.0,
                  iconTheme: const QuillIconTheme(
                      disabledIconColor: Colors.black26,
                      iconSelectedFillColor: Colors.transparent,
                      iconSelectedColor: CupertinoColors.activeBlue,
                      iconUnselectedFillColor: Colors.transparent),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future editNote(Note n, String t, int c, int tc, List<dynamic> cn) async {
    n.title = t;
    n.color = c;
    n.txtColor = tc;
    n.content = cn;
    n.save();
  } //add note

  void showSnackMsg(String msg, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      elevation: 0.0,
      duration: const Duration(seconds: 2),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      width: 100.0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } //show snack msg

  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  } //_onImagePickCallback

  Future<String> _onVideoPickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  } //_onVideoPickCallback
}
