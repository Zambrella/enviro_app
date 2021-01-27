import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final bool active;
  final Function function;
  PrimaryButton({@required this.label, this.active, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: kPrimaryColor,
      onTap: function,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? kSecondaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: kSecondaryColor.withOpacity(0.40),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
