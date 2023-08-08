import 'package:flutter/cupertino.dart';

class CountryName extends ChangeNotifier {
  String? Country;
  String? type;
  List<String> VatRate = [];
  bool themeChange = false;
  bool firstTime = true;
  List<bool> Contenders = [];
  bool provider_isAlreadyDone = false;

  void setCountryName(String name) {
    Country = name;
    notifyListeners();
  }

  void setType(String Type) {
    type = Type;
    notifyListeners();
  }

  void setVatRate(List<String> CountryRate) {
    VatRate = CountryRate;
    Contenders = List.filled(CountryRate.length, false);
    provider_isAlreadyDone = false;
    print('vat rate is $VatRate');
    notifyListeners();
  }

  void setOccurences(bool occurence) {
    firstTime = occurence;
    notifyListeners();
  }

  void setThemeStatus(bool themeStatus) {
    themeChange = themeStatus;
    notifyListeners();
  }

  void setContenders(List<bool> con) {
    Contenders = con;
  }
}
