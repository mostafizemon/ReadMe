import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginSignupOptionalText extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onTap;
  const LoginSignupOptionalText({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "$text ",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
          children: [
            TextSpan(
              text: buttonText,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
