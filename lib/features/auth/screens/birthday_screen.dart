import 'package:anime_app/features/auth/screens/create_password.dart';
import 'package:anime_app/providers/language.dart';
import 'package:anime_app/theme/theme.dart';
// import 'package:anime_app/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../widgets/motion_toast.dart';
import '../../../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BirthdaySelect extends StatefulWidget {
  final String username;
  final String email;
  const BirthdaySelect({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  State<BirthdaySelect> createState() => _BirthdaySelectState();
}

class _BirthdaySelectState extends State<BirthdaySelect> {
  // String _selectedLanguage;

  DateTime _selectedDateTime = DateTime(1999, 08, 25);
  var selectedDate;

  birthdayTile() => Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.birthday,
              style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            // CupertinoDatePicker(onDateTimeChanged: onBirthdayChange),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8, backgroundColor: AppColors.secondary),
              child: Text(
                  selectedDate == null
                      ? AppLocalizations.of(context)!.chooseDate
                      : 'You selected: $selectedDate',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: AppColors.textLigth)),
              onPressed: () {
                setState(() async {
                  DatePicker.showSimpleDatePicker(
                    context,
                    initialDate: DateTime(1994),
                    firstDate: DateTime(1960),
                    lastDate: DateTime(DateTime.now().year - 13),
                    dateFormat: "dd-MM-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping: false,
                  ).then((value) {
                    setState(() {
                      selectedDate =
                          '${value!.day} / ${value.month} / ${value.year}';
                    });
                  });
                });
              },
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.iconLight,
          ),
          title: Text(
            AppLocalizations.of(context)!.birthday,
            style:
                GoogleFonts.lobster(color: AppColors.secondary, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
          child: Column(children: <Widget>[
            // selectedText,
            const SizedBox(height: 15.0),
            birthdayTile(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.createPass,
                  style: GoogleFonts.lobster(
                      color: AppColors.secondary, fontSize: 25),
                ),
                const Spacer(),
                InkWell(
                  splashColor: AppColors.secondary,
                  onTap: () {
                    // print('object');
                    print(widget.username);
                    print(widget.email);
                    print(selectedDate);

                    navPush(
                        context,
                        CreatePassword(
                          email: widget.email,
                          username: widget.username,
                          birthday: selectedDate.toString().trim(),
                        ));

                    //
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xff2E99C7),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
