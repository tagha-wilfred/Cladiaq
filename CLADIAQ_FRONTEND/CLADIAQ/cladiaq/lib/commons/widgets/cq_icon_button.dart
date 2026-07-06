import 'package:cladiaq/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CqIconButton extends StatelessWidget {
  final String icon;
  final bool disabled;
  final VoidCallback onPressedCq;
  const CqIconButton({
    Key? key,
    required this.icon,
    required this.onPressedCq,
    this.disabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedCq,
      child: Container(
          width: 40,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: disabled ? cqPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: cqPrimaryColor)),
          child: Text(icon,
              style: TextStyle(
                  color: disabled ? Colors.white : cqPrimaryColor,
                  fontSize: 9))),
    );
  }
}
