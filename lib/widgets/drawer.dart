import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vat_calculator/provider/selected_country.dart';
import 'package:vat_calculator/provider/theme_provider.dart';
import 'package:vat_calculator/screens/vat_screen.dart';

class drawer extends StatelessWidget {
  vatScreen _vatScreen = vatScreen();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryName>(context, listen: false);

    return Consumer<ThemeProvider>(builder: (context, data, _) {
      return Container(
        child: CountryCodePicker(
          initialSelection: '+92',
          // padding: EdgeInsets.only(rig),
          onInit: (code) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.setOccurences(true);
              provider.setCountryName(code!.name ?? '');
              provider.setThemeStatus(true);
              setRates(context, code, provider);
            });
          },

          onChanged: (Code) {
            provider.setCountryName(Code.name ?? '');
            provider.setThemeStatus(false);
            setRates(context, Code, provider);
          },
          dialogBackgroundColor:
              data.themeMode == ThemeMode.dark ? Colors.black : Colors.white,

          dialogSize: MediaQuery.of(context).size,

          hideMainText: true,

          showCountryOnly: true,
        ),
      );
    });
  }

  void setRates(BuildContext context, CountryCode? code, CountryName provider) {
    switch (code!.dialCode) {
      case '+66':
        return provider.setVatRate(['7']);
      case '+355':
        return provider.setVatRate(['20']);
      case '+213':
        return provider.setVatRate(['19']);
      case '+376':
        return provider.setVatRate(['4.50']);
      case '+244':
        return provider.setVatRate(['14']);
      case '+1':
        return provider.setVatRate(['15']);
      case '+54':
        return provider.setVatRate(['21', '27', '10.5']);
      case '+374':
        return provider.setVatRate(['20']);
      case '+297':
        return provider.setVatRate(['18']);
      case '+61':
        return provider.setVatRate(['18']);
      case '+43':
        return provider.setVatRate(['20']);
      case '+994':
        return provider.setVatRate(['18']);
      case '+351':
        return provider.setVatRate(['23']);
      case '+1':
        return provider.setVatRate(['10']);
      case '+973':
        return provider.setVatRate(['5']);
      case '+880':
        return provider.setVatRate(['15']);
      case '+1':
        return provider.setVatRate(['17.50']);
      case '+375':
        return provider.setVatRate(['20']);
      case '+32':
        return provider.setVatRate(['21']);
      case '+501':
        return provider.setVatRate(['12.50']);
      case '+229':
        return provider.setVatRate(['18']);
      case '+591':
        return provider.setVatRate(['13']);
      case '+387':
        return provider.setVatRate(['17']);
      case '+267':
        return provider.setVatRate(['12']);
      case '+55':
        return provider.setVatRate(['18']);
      case '+359':
        return provider.setVatRate(['20']);
      case '+226':
        return provider.setVatRate(['18']);
      case '+257':
        return provider.setVatRate(['18']);
      case '+855':
        return provider.setVatRate(['10']);
      case '+237':
        return provider.setVatRate(['19.25']);
      case '+1':
        return provider.setVatRate(['5']);
      case '+238':
        return provider.setVatRate(['15']);
      case '+236':
        return provider.setVatRate(['19']);
      case '+56':
        return provider.setVatRate(['19']);
      case '+86':
        return provider.setVatRate(['13']);
      case '+57':
        return provider.setVatRate(['19']);
      case '+682':
        return provider.setVatRate(['15']);
      case '+243':
        return provider.setVatRate(['18']);
      case '+243':
        return provider.setVatRate(['18']);
      case '+506':
        return provider.setVatRate(['13']);
      case '+357':
        return provider.setVatRate(['19']);
      case '+420':
        return provider.setVatRate(['21']);
      case '+45':
        return provider.setVatRate(['25']);
      case '+1':
        return provider.setVatRate(['15']);
      case '+1':
        return provider.setVatRate(['18']);
      case '+593':
        return provider.setVatRate(['12']);
      case '+20':
        return provider.setVatRate(['14']);
      case '+503':
        return provider.setVatRate(['13']);
      case '+268':
        return provider.setVatRate(['15']);
      case '+679':
        return provider.setVatRate(['15']);
      case '+358':
        return provider.setVatRate(['24']);
      case '+33':
        return provider.setVatRate(['20']);
      case '+241':
        return provider.setVatRate(['18']);
      case '+49':
        return provider.setVatRate(['19']);
      case '+995':
        return provider.setVatRate(['18']);
      case '+233':
        return provider.setVatRate(['12.50']);
      case '+30':
        return provider.setVatRate(['24']);
      case '+509':
        return provider.setVatRate(['10']);
      case '+36':
        return provider.setVatRate(['27']);
      case '+354':
        return provider.setVatRate(['24']);
      case '+91':
        return provider.setVatRate(['18', '12']);
      case '+62':
        return provider.setVatRate(
            ['5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']);
      case '+353':
        return provider.setVatRate(['23']);
      case '+44':
        return provider.setVatRate(['20']);
      case '+972':
        return provider.setVatRate(['17']);
      case '+39':
        return provider.setVatRate(['22']);
      case '+1':
        return provider.setVatRate(['20']);
      case '+81':
        return provider.setVatRate(['10']);
      case '+44':
        return provider.setVatRate(['5']);
      case '+962':
        return provider.setVatRate(['16']);
      case '+7':
        return provider.setVatRate(['12']);
      case '+254':
        return provider.setVatRate(['16']);
      case '+383':
        return provider.setVatRate(['18']);
      case '+850':
        return provider.setVatRate(['15']);
      case '+82':
        return provider.setVatRate(['10']);
      case '+423':
        return provider.setVatRate(['7.7']);
      case '+370':
        return provider.setVatRate(['21']);
      case '+352':
        return provider.setVatRate(['21']);
      case '+351':
        return provider.setVatRate(['17']);
      case '+352':
        return provider.setVatRate(['17']);
      case '+351':
        return provider.setVatRate(['22']);
      case '+60':
        return provider.setVatRate(['6']);
      case '+960':
        return provider.setVatRate(['6']);
      case '+356':
        return provider.setVatRate(['18']);
      case '+60':
        return provider.setVatRate(['6']);
      case '+960':
        return provider.setVatRate(['6']);
      case '+356':
        return provider.setVatRate(['18']);
      case '+692':
        return provider.setVatRate(['8', '9', '10', '11', '12']);
      case '+230':
        return provider.setVatRate(['15']);
      case '+92':
        return provider.setVatRate(['17']);
      case '+372':
        return provider.setVatRate(['20', '9', '5', '0']);

      default:
        provider.setVatRate([]);
        provider.setOccurences(false);
    }
  }
}
