import '../../constants/ui_constants.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final bool isSelected;
  final String buttonText;
  final Function buttonFunction;
  SelectButton(
      {@required this.isSelected,
      @required this.buttonText,
      @required this.buttonFunction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: buttonFunction,
        child: Container(
          width: 110,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? kPrimaryColor : Colors.grey[300]),
          child: Center(
            child: Text(
              buttonText,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: isSelected ? Colors.white : kPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
