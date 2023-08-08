import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vat_calculator/provider/selected_country.dart';
import 'package:vat_calculator/provider/theme_provider.dart';
import 'package:vat_calculator/resources/resource.dart';
import 'package:vat_calculator/screens/settings.dart';
import 'package:vat_calculator/screens/vat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CountryName(),
          )
        ],
        child: Consumer<ThemeProvider>(builder: (context, data, _) {
          return MaterialApp(
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode:
                data.themeMode, // Decides which theme to show, light or dark.
            initialRoute: routes.home,
            onGenerateRoute: RouteGenerator.getRoute,
          );
        }));
  }
}
