import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/styles.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:flutter/material.dart';

class CqButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final bool outline;
  final bool outlineblue;
  final Widget? leading;
  final VoidCallback onPressedCq;
  const CqButton(
      {Key? key,
      required this.title,
      required this.onPressedCq,
      this.outlineblue = false,
      this.disabled = false,
      this.busy = false,
      this.outline = false,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedCq,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 58,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled ? cqPrimaryColor : cqMediumGreyColor,
                borderRadius: BorderRadius.circular(8),
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey.shade600,
                //       spreadRadius: 1,
                //       blurRadius: 15,
                //       offset: const Offset(0, 15))
                // ],
                border: Border.all(
                    color: !disabled ? cqPrimaryColor : cqMediumGreyColor))
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: !outlineblue ? cqMediumGreyColor : cqPrimaryColor,
                    width: 1)),
        child: !busy
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: leading,
                  ),
                  if (leading != null) horizontalSpaceMedium,
                  Text(
                    title,
                    style: bodyStyle.copyWith(
                        fontWeight:
                            !outline ? FontWeight.bold : FontWeight.w400,
                        color: !outline
                            ? Colors.white
                            : !outlineblue
                                ? cqMediumGreyColor
                                : cqPrimaryColor),
                  )
                ],
              )
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 5,
              ),
      ),
    );
  }
}
