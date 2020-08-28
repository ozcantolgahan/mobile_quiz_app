import 'package:flutter/material.dart';
import 'package:quiz_app/view_model/user_view_model.dart';

class ClipOvalWidget extends StatelessWidget {
  void Function() onTap;
  Icon iconSign;
  Color clipColor;

  ClipOvalWidget({this.onTap, this.iconSign, this.clipColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: clipColor, // button color
        child: InkWell(
          splashColor: clipColor, // inkwell color
          child: SizedBox(width: 56, height: 56, child: iconSign),
          onTap: onTap,
        ),
      ),
    );
  }
}
