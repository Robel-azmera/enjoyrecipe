import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color labelColor;

  RoundedButton(
      {@required this.text,
      @required this.onPressed,
      @required this.color,
      this.labelColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 363.4,
          height: 61.0,
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0, color: labelColor),
          ),
        ),
      ),
    );
  }
}
