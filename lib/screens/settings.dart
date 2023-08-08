import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vat_calculator/provider/selected_country.dart';
import 'package:vat_calculator/resources/resource.dart';
import 'package:vat_calculator/widgets/change_theme_button_widget.dart';
import 'package:vat_calculator/widgets/drawer.dart';

class settings extends StatefulWidget {
  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
          title: Text('Settings'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              //overall
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //first
                  margin:
                      EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 20),

                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(routes.history);
                              },
                              child: Row(
                                children: [
                                  Container(
                                      child: Icon(
                                    Icons.history,
                                    size: 30,
                                    color: Colors.blue,
                                  )),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'History',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text('Last 5 calculations')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          changeThemeButtonWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
