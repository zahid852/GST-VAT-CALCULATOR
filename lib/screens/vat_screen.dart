import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vat_calculator/Model/model.dart';
import 'package:vat_calculator/provider/selected_country.dart';
import 'package:vat_calculator/provider/theme_provider.dart';
import 'package:vat_calculator/resources/resource.dart';
import 'package:vat_calculator/widgets/drawer.dart';

class vatScreen extends StatefulWidget {
  @override
  State<vatScreen> createState() => _vatScreenState();
}

class _vatScreenState extends State<vatScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController perController = TextEditingController();
  double percentage = 0.0;
  double amount = 0;
  double vat = 0.0;
  double net = 0;
  bool isAlreadyDone = false;
  double total = 0;
  bool isAnyTrue = false;
  List<Widget> widgets = [];
  SharedPreferences? prefs;
  List<bool> isSelected = [];
  List<Record> records = [];
  String temp = '';
  bool otherWay = false;
  late CountryName getr;
  List<Record> last5Records = [];
  @override
  void initState() {
    getr = Provider.of<CountryName>(context, listen: false);
    callPreferences();
    // TODO: implement initState
    super.initState();
  }

  void callPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void getData() {
    showDialog(

        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         topLeft:
        //             Radius.circular(20),
        //         topRight:
        //             Radius.circular(20))),
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.only(left: 27, top: 17, bottom: 15),
                          child: Text(
                            'Add Custom Vat Rate',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              controller: perController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintText: 'Enter vat rate',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 90,
                      padding: EdgeInsets.only(bottom: 0, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (perController.text.isEmpty) {
                                  return;
                                }
                                temp = perController.text;
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  getr.setVatRate([temp]);
                                });
                                perController.clear();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final countryProvider = Provider.of<CountryName>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text('${countryProvider.type ?? ''} Calculator'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(routes.SettingsRoute);
                },
                icon: Icon(Icons.settings))
          ],
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorWidth: 3,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.0',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      hintStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<CountryName>(
                          builder: ((context, data, _) => Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  data.Country ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            drawer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                '.',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(
                              '   ${countryProvider.type ?? ''} rates',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Consumer<CountryName>(builder: (context, data, _) {
                  if (data.VatRate.isEmpty) {
                    otherWay = true;

                    return Container(
                      padding: EdgeInsets.only(left: 17),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              primary: Colors.blue,
                              textStyle: TextStyle(color: Colors.white)),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              getData();
                            });
                          },
                          child: Text(
                            'Add Custum Rate',
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  }
                  isAlreadyDone = data.provider_isAlreadyDone;
                  if (data.Contenders.length != 0) {
                    isSelected = data.Contenders;
                  }
                  if (isAlreadyDone == false) {
                    if (data.Contenders.length == 1) {
                      isSelected = [true];

                      percentage = double.parse(data.VatRate[0]);
                      otherWay = false;
                    } else if (data.Contenders.length == 0) {
                      isSelected = [true];
                    } else {
                      isSelected[0] = true;
                      otherWay = false;
                      percentage = double.parse(data.VatRate[0]);
                    }
                  }

                  if (data.VatRate.isEmpty &&
                      data.firstTime == false &&
                      data.themeChange == false)
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      countryProvider.setOccurences(true);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        getData();
                                      });
                                    },
                                    child: Text(
                                      'Custom rate',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      countryProvider.setOccurences(true);
                                    },
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                              title: Text(
                                'Sorry!',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              content: Text(
                                "We don't have ${data.Country} Vat rate.",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          });
                    });
                  return Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Center(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.VatRate.length,
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  isAlreadyDone = true;
                                  data.provider_isAlreadyDone = true;
                                  for (int i = 0;
                                      i < data.VatRate.length;
                                      i++) {
                                    if (i == ind) {
                                      isSelected[ind] = true;
                                      otherWay = false;
                                      percentage =
                                          double.parse(data.VatRate[ind]);
                                    } else {
                                      isSelected[i] = false;
                                    }
                                  }
                                  countryProvider.setContenders(isSelected);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35)),
                                child: Card(
                                  elevation: 0,
                                  color: isSelected[ind]
                                      ? Colors.blue
                                      : (themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? Colors.white
                                          : Colors.grey[350]),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 8),
                                        child: Text(
                                          '${data.VatRate[ind]}%',
                                          style: TextStyle(
                                            color: isSelected[ind]
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: DottedBorder(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      borderType: BorderType.RRect,
                      dashPattern: [4, 3],
                      radius: Radius.circular(5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NET'),
                              Text(net.toStringAsFixed(2))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(countryProvider.type ?? ''),
                              Text(vat.toStringAsFixed(2))
                            ],
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: DottedBorder(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      borderType: BorderType.RRect,
                      dashPattern: [4, 3],
                      radius: Radius.circular(5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL'),
                          Text(total.toStringAsFixed(2))
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        onPressed: () async {
                          if (numberController.text.isEmpty) {
                            return WidgetsBinding.instance
                                .addPostFrameCallback((_) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.blue,
                                                textStyle: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              countryProvider
                                                  .setOccurences(true);
                                            },
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                      title: Text(
                                        'Failure!',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      content: Text(
                                        "Please enter amount for the calculation",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  });
                            });
                          }
                          amount = double.parse(numberController.text);
                          if (otherWay == true) {
                            percentage = double.parse(perController.text);
                          }
                          FocusScope.of(context).unfocus();
                          setState(() {
                            vat = ((percentage / 100) * amount);
                            net = (amount + vat);
                            total = vat + net;
                          });
                          records.insert(
                              0,
                              Record(
                                  CountryVat: percentage.toString(),
                                  net: net.toString(),
                                  vat: vat.toString(),
                                  total: total.toString(),
                                  method: 'Remove',
                                  type: countryProvider.type!));
                          final userData = json.encode({
                            'cv': records[0].CountryVat,
                            'net': records[0].net,
                            'vat': records[0].vat,
                            'total': records[0].total,
                            'method': records[0].method,
                            'type': records[0].type,
                          });
                          if (prefs!.containsKey('data${0}')) {
                            final data1 = prefs!.getString('data${0}');
                            await prefs!.setString('data${0}', userData);
                            if (prefs!.containsKey('data${1}')) {
                              final data2 = prefs!.getString('data${1}');
                              await prefs!.setString('data${1}', data1!);
                              if (prefs!.containsKey('data${2}')) {
                                final data3 = prefs!.getString('data${2}');
                                await prefs!.setString('data${2}', data2!);
                                if (prefs!.containsKey('data${3}')) {
                                  final data4 = prefs!.getString('data${3}');
                                  await prefs!.setString('data${3}', data3!);
                                  if (prefs!.containsKey('data${4}')) {
                                    await prefs!.setString('data${4}', data4!);
                                  } else {
                                    await prefs!.setString('data${4}', data4!);
                                  }
                                } else {
                                  await prefs!.setString('data${3}', data3!);
                                }
                              } else {
                                await prefs!.setString('data${2}', data2!);
                              }
                            } else {
                              await prefs!.setString('data${1}', data1!);
                            }
                          } else {
                            await prefs!.setString('data${0}', userData);
                          }
                        },
                        child: Text('INCLUDE',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              elevation: 0,
                              side: BorderSide(
                                color: Colors.red,
                              )),
                          onPressed: () async {
                            if (numberController.text.isEmpty) {
                              return WidgetsBinding.instance
                                  .addPostFrameCallback((_) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue,
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                countryProvider
                                                    .setOccurences(true);
                                              },
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ],
                                        title: Text(
                                          'Failure!',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        content: Text(
                                          "Please enter amount for the calculation",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      );
                                    });
                              });
                            }
                            if (otherWay == true) {
                              percentage = double.parse(perController.text);
                            }
                            amount = double.parse(numberController.text);
                            FocusScope.of(context).unfocus();
                            setState(() {
                              vat =
                                  ((amount * percentage) / (100 + percentage));
                              net = ((amount * 100) / (100 + percentage));
                              total = vat + net;
                            });
                            records.insert(
                                0,
                                Record(
                                    CountryVat: percentage.toString(),
                                    net: net.toString(),
                                    vat: vat.toString(),
                                    total: total.toString(),
                                    method: 'Add',
                                    type: countryProvider.type!));

                            final userData = json.encode({
                              'cv': records[0].CountryVat,
                              'net': records[0].net,
                              'vat': records[0].vat,
                              'total': records[0].total,
                              'method': records[0].method,
                              'type': records[0].type,
                            });
                            if (prefs!.containsKey('data${0}')) {
                              final data1 = prefs!.getString('data${0}');
                              await prefs!.setString('data${0}', userData);
                              if (prefs!.containsKey('data${1}')) {
                                final data2 = prefs!.getString('data${1}');
                                await prefs!.setString('data${1}', data1!);
                                if (prefs!.containsKey('data${2}')) {
                                  final data3 = prefs!.getString('data${2}');
                                  await prefs!.setString('data${2}', data2!);
                                  if (prefs!.containsKey('data${3}')) {
                                    final data4 = prefs!.getString('data${3}');
                                    await prefs!.setString('data${3}', data3!);
                                    if (prefs!.containsKey('data${4}')) {
                                      await prefs!
                                          .setString('data${4}', data4!);
                                    } else {
                                      await prefs!
                                          .setString('data${4}', data4!);
                                    }
                                  } else {
                                    await prefs!.setString('data${3}', data3!);
                                  }
                                } else {
                                  await prefs!.setString('data${2}', data2!);
                                }
                              } else {
                                await prefs!.setString('data${1}', data1!);
                              }
                            } else {
                              await prefs!.setString('data${0}', userData);
                            }
                          },
                          child: Text(
                            'EXCLUDE',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                )
              ],
            ))),
      ),
    );
  }
}
