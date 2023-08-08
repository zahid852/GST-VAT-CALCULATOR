import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vat_calculator/Model/model.dart';
import 'package:vat_calculator/provider/theme_provider.dart';

class historyScreen extends StatefulWidget {
  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {
  List<Map<String, dynamic>> records = [];
  Future? _future;

  @override
  void didChangeDependencies() {
    _future = getData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  dynamic data0;
  dynamic data1;
  dynamic data2;
  dynamic data3;
  dynamic data4;
  // bool bdata0 = false;
  // bool bdata1 = false;
  // bool bdata2 = false;
  // bool bdata3 = false;
  // bool bdata4 = false;
  Future<void> getData() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    // _sharedPreferences.remove('data0');
    // _sharedPreferences.remove('data1');
    // _sharedPreferences.remove('data2');
    // _sharedPreferences.remove('data3');
    // _sharedPreferences.remove('data4');

    if (_sharedPreferences.containsKey('data0')) {
      data0 = json.decode(_sharedPreferences.getString('data0') ?? '')
          as Map<String, dynamic>;
      records.add(data0);
    }
    if (_sharedPreferences.containsKey('data1')) {
      data1 = json.decode(_sharedPreferences.getString('data1') ?? '')
          as Map<String, dynamic>;
      records.add(data1);
    }
    if (_sharedPreferences.containsKey('data2')) {
      data2 = json.decode(_sharedPreferences.getString('data2') ?? '')
          as Map<String, dynamic>;
      records.add(data2);
    }
    if (_sharedPreferences.containsKey('data3')) {
      data3 = json.decode(_sharedPreferences.getString('data3') ?? '')
          as Map<String, dynamic>;
      records.add(data3);
    }
    if (_sharedPreferences.containsKey('data4')) {
      data4 = json.decode(_sharedPreferences.getString('data4') ?? '')
          as Map<String, dynamic>;
      records.add(data4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    print('records $records');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        title: Text('History'),
      ),
      body: Container(
        child: FutureBuilder(
            future: _future,
            builder: (context, Snapshot) {
              if (Snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (records.isEmpty) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Lottie.asset('assets/empty.json'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text("You didn't perfom any calculation",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Go Back',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemCount: records.length,
                  itemBuilder: (context, ind) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${records[ind]['type']} Rate",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    " ${records[ind]['cv']}% -",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    " ${records[ind]['method']}",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          Container(
                            child: Column(children: [
                              Container(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.grey[800]
                                    : Colors.white,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: DottedBorder(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    borderType: BorderType.RRect,
                                    dashPattern: [4, 3],
                                    radius: Radius.circular(5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('NET'),
                                            Text(double.parse(
                                                    records[ind]['net'])
                                                .toStringAsFixed(2))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(records[ind]['type']),
                                            Text(double.parse(
                                                    records[ind]['vat'])
                                                .toStringAsFixed(2))
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.grey[800]
                                    : Colors.white,
                                // decoration:
                                //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: DottedBorder(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    borderType: BorderType.RRect,
                                    dashPattern: [4, 3],
                                    radius: Radius.circular(5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('TOTAL'),
                                        Text(double.parse(records[ind]['total'])
                                            .toStringAsFixed(2))
                                      ],
                                    )),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
