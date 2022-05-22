import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xnotes/animations/page_transition.dart';

import 'package:xnotes/pages/settings_page.dart';
import 'package:xnotes/pages/workspace.dart';
import 'package:xnotes/widgets/all_notes.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:xnotes/widgets/favorite_notes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'X-Notes',
        ),
        actions: [
          IconButton(
              onPressed: () {
                goToWorkspace(context);
              },
              icon: const Icon(CupertinoIcons.add)),
          IconButton(
              onPressed: () {
                goToSettings(context);
              },
              icon: const Icon(Icons.settings_outlined))
        ],
      ),
      body: Container(
          child: currentIndex == 0 ? const AllNotes() : const FavoriteNotes()),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        showElevation: false,
        selectedIndex: currentIndex,
        items: [
          BottomNavyBarItem(
            icon: const Icon(CupertinoIcons.doc_text_fill),
            title: const Text('Notes'),
            textAlign: TextAlign.center,
            activeColor: CupertinoColors.activeBlue,
          ),
          BottomNavyBarItem(
              icon: const Icon(CupertinoIcons.heart_fill),
              title: const Text('Favorite'),
              textAlign: TextAlign.center,
              activeColor: CupertinoColors.systemPink),
        ],
      ),
    );
  }

  void goToWorkspace(context) {
    Navigator.of(context).push(CustomPageRoute(child: const Workspace()));
  } //goto workspace

  void goToSettings(context) {
    Navigator.of(context).push(CustomPageRoute(child: const SettingsPage()));
  } //goto settings
}
