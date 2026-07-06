import 'package:cladiaq/commons/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CqToogleButton extends StatelessWidget {
  final bool toggleValue;
  final VoidCallback toggleFunct;
  CqToogleButton(
      {super.key, this.toggleValue = false, required this.toggleFunct});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleFunct,
      child: AnimatedContainer(
        height: 40.0,
        width: 35,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: toggleValue ? cqLightGreyColor : cqPrimaryColor),
        child: Stack(children: [
          Positioned(
            left: toggleValue ? 1 : null,
            right: toggleValue ? null : 1,
            top: 2,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.5)),
            ),
          )
        ]),
      ),
    );
  }
}
