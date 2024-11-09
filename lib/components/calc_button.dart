import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Color? buttonColor;
  final String buttonText;
  final Color? buttonTextColor;
  final Function()? buttonTapped;

  const CalcButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
