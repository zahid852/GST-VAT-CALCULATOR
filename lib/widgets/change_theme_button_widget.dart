import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vat_calculator/provider/selected_country.dart';
import 'package:vat_calculator/provider/theme_provider.dart';

class changeThemeButtonWidget extends StatefulWidget {
  @override
  State<changeThemeButtonWidget> createState() =>
      _changeThemeButtonWidgetState();
}

class _changeThemeButtonWidgetState extends State<changeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final provider = Provider.of<CountryName>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(bottom: 0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  height: 190,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 22),
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close)),
                            centerTitle: true,
                            title: Text(
                              'Theme',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.light_mode),
                                      Padding(
                                          padding: EdgeInsets.only(right: 10)),
                                      Text('Light mode')
                                    ],
                                  ),
                                  Container(
                                    width: 30,
                                    child: RadioListTile(
                                        value: 0,
                                        selected: true,
                                        groupValue:
                                            themeProvider.themeModeValue,
                                        onChanged: (value) {
                                          themeProvider
                                              .toggleTheme(value as int);
                                          provider.setThemeStatus(true);
                                        }),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.dark_mode),
                                      Padding(
                                          padding: EdgeInsets.only(right: 10)),
                                      Text('Dark mode')
                                    ],
                                  ),
                                  Container(
                                    width: 30,
                                    child: RadioListTile(
                                        value: 1,
                                        groupValue:
                                            themeProvider.themeModeValue,
                                        onChanged: (value) {
                                          themeProvider
                                              .toggleTheme(value as int);
                                          provider.setThemeStatus(true);
                                        }),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Row(
          children: [
            Container(
                child: Icon(
              Icons.change_circle_outlined,
              size: 30,
              color: Colors.blue,
            )),
            SizedBox(
              width: 30,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(themeProvider.themeMode == ThemeMode.dark
                      ? 'Dark'
                      : 'Light')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
