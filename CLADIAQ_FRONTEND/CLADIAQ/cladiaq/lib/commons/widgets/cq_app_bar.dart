import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CqAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasNotifications;

  // Define a preferred size for the AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  CqAppBar({required this.title, required this.hasNotifications});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
            // backgroundImage: AssetImage(
            //     "assets/images/profile.png"), // Replace with your profile image
            ),
      ),
      title: CqText.heading3(title),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          height: 50,
          width: 50,
          child: Stack(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/notification.svg",
                  height: 50,
                  width: 50,
                ),
                onPressed: () {
                  // Handle notification tap
                },
              ),
              if (hasNotifications)
                Positioned(
                  right: 12,
                  top: 3,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: const BoxDecoration(
                      color: cqNotification,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
    );
  }
}
