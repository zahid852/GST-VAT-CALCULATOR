import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyThemes {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xfFf3f3f0),
      colorScheme: ColorScheme.light().copyWith(primary: Colors.blue),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Color(0xfFf3f3f0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Colors.grey[800]),
          color: Color(0xfff3f3f0),
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.blue)));
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              primary: Colors.grey.shade900)),
      appBarTheme: AppBarTheme(
          color: Colors.grey.shade900,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Colors.white70),
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.blue)),
      colorScheme: ColorScheme.dark().copyWith(primary: Colors.blue));
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  int themeModeValue = 0;

  void toggleTheme(int value) {
    value == 1 ? themeMode = ThemeMode.dark : themeMode = ThemeMode.light;
    themeModeValue = value;
    notifyListeners();
  }
}
