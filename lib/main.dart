import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xnotes/models/note.dart';
import 'package:xnotes/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  await Hive.openBox('usertheme');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('usertheme').listenable(),
        builder: ((context, box, _) {
          final b = Hive.box('usertheme');
          final storedTheme = b.get('userChoiceTheme');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: storedTheme == 'dark'
                ? ThemeMode.dark
                : storedTheme == 'light'
                    ? ThemeMode.light
                    : ThemeMode.system,
            theme: ThemeData(
                snackBarTheme: const SnackBarThemeData(
                    backgroundColor: CupertinoColors.activeBlue,
                    contentTextStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold)),
                appBarTheme: const AppBarTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20.0))),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  elevation: 0.0,
                  backgroundColor: CupertinoColors.activeBlue,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Varela',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                  actionsIconTheme: IconThemeData(color: Colors.white),
                ),
                iconTheme: const IconThemeData(color: Colors.grey)),
            darkTheme: ThemeData(
                snackBarTheme: const SnackBarThemeData(
                    backgroundColor: CupertinoColors.white,
                    contentTextStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold)),
                appBarTheme: const AppBarTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20.0))),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    titleTextStyle: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                colorScheme: const ColorScheme.dark(),
                iconTheme: const IconThemeData(color: Colors.white)),
            home: const Home(),
          );
        }));
  }
}
