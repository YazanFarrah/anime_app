import 'dart:async';

import 'package:anime_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/buttons/timer_text_button.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

int secondsRemaining = 30;
bool enableResend = false;
Timer? timer;

class _OtpFormState extends State<OtpForm> {
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.textDark,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Verification code',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Text(
              'Verification code sent to {email}',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  otpTextInput(context),
                  otpTextInput(context),
                  otpTextInput(context),
                  otpTextInput(context),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.secondary,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //         )),
            //     child: const Text('Resend code'),
            //     onPressed: () {},
            //   ),
            // ),

            const ResendCodeButton(),
          ]),
        ),
      ),
    );
  }

  SizedBox otpTextInput(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10.0));
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        decoration: InputDecoration(
          border: inputBorder,
          enabledBorder: inputBorder,
          errorBorder: inputBorder,
          filled: true,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (pin) {},
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
