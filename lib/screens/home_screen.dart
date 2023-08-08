import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vat_calculator/provider/selected_country.dart';
import 'package:vat_calculator/provider/theme_provider.dart';
import 'package:vat_calculator/resources/resource.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryName>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.delayed(Duration(seconds: 0), () {
          return false;
        });
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.blue),
          ),
          body: Container(
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.grey.shade900
                : Colors.grey[300],
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            height: 120,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 35),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  alignment: Alignment.center,
                                  child: Text('GST & VAT Calculator',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  height: 60))
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      'What do you want to do today?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          provider.setType('GST');
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed(routes.vatRoute);
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: Colors.orange[800],
                                    borderRadius: BorderRadius.circular(5)),
                                height: double.infinity,
                                child: Icon(
                                  Icons.calculate_outlined,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'GST Calculator',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(bottom: 20),
                    height: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          provider.setType('VAT');
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed(routes.vatRoute);
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: Colors.orange[800],
                                    borderRadius: BorderRadius.circular(5)),
                                height: double.infinity,
                                child: Icon(
                                  Icons.calculate_outlined,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'VAT Calculator',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
