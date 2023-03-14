import 'dart:async';

import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String phoneNumber;

  VerifyCodeScreen({required this.phoneNumber});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  List<TextEditingController> codeControllers = [];
  late int timeRemaining;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      codeControllers.add(TextEditingController());
    }
    timeRemaining = 60; // Set the time limit for entering the code
    startTimer(); // Start the timer
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void verifyCode() {
    // Combine the 6 codes into a single code
    String verificationCode = "123456";
    for (int i = 0; i < 6; i++) {
      verificationCode += codeControllers[i].text;
    }
    // Call API to verify the code
    // If the verification is successful, show a success message
    // If the verification fails, show an error message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Phone Number"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter the verification code we just sent to ${widget.phoneNumber}",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 6; i++)
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: codeControllers[i],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onChanged: (value) {
                        if (i < 5 && value.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (i == 5 && value.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: timeRemaining == 0 ? startTimer : null,
              child: Text(timeRemaining > 0
                  ? "Resend Code in $timeRemaining seconds"
                  : "Resend Code"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => verifyCode(),
              child: Text("Verify"),
            ),
            SizedBox(height: 16),
            Text(
              "Error message goes here",
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
            Text("Success message goes here"),
          ],
        ),
      ),
    );
  }
}
