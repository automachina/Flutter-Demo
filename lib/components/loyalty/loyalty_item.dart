import 'package:flutter/material.dart';
import 'package:test_drive/models/loyalty.dart';
import 'package:test_drive/utilities/color.dart';

import '../drop_shadow.dart';

class LoyaltyItem extends StatelessWidget {
  final Goal goal;
  final VoidCallback? onTap;
  final Color? color;
  final Color? backgroundColor;
  final Color? dropShadowColor;
  const LoyaltyItem({
    Key? key,
    required this.goal,
    this.onTap,
    this.color,
    this.backgroundColor,
    this.dropShadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bgColor = backgroundColor ?? context.theme.colorScheme.background;
    var dsColor = dropShadowColor ?? context.theme.colorScheme.primary;
    var textStyle = context.theme.textTheme.bodyText1?.copyWith(color: color);
    var iconColor = color ?? context.theme.textTheme.bodyText1?.color;
    return DropShadow(
      opacity: 0.6,
      color: dsColor,
      offset: const Offset(3, 3),
      sigma: 7,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: bgColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  goal.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: iconColor,
                ),
              ),
              Center(
                  child: Text(
                goal.name,
                style: textStyle,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
