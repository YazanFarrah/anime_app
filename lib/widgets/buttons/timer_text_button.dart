import 'dart:async';

import 'package:flutter/material.dart';

class ResendCodeButton extends StatefulWidget {
  const ResendCodeButton({super.key});

  @override
  _ResendCodeButtonState createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  // Declare a timer and a counter
  Timer? _timer;
  int _counter = 60;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Start the timer and decrement the counter every 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: _counter > 0 ? _startTimer : null,
        child: Text('Resend code in $_counter seconds'),
      ),
    );
  }
}
