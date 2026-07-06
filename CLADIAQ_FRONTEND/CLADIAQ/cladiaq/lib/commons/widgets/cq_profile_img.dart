import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CqProfileImg extends StatelessWidget {
  const CqProfileImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Image.asset("assets/images/img_placeholder.png"),
          Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/icons/cq_edit.svg",
              ))
        ],
      ),
    );
  }
}
