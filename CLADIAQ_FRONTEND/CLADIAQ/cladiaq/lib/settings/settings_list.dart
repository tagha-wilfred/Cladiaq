import 'package:cladiaq/settings/settings_list_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

final List<Item> items = [
  Item(
    text: 'Account',
    leadingIcon: const SvgListPicture(icon: "assets/icons/cq_person.svg"),
  ),
  Item(
    text: 'Notifications',
    leadingIcon: const SvgListPicture(icon: "assets/icons/notification.svg"),
  ),
  Item(
    text: 'Change Language',
    leadingIcon: const SvgListPicture(icon: "assets/icons/language.svg"),
  ),
  Item(
    text: 'Terms & Conditions',
    leadingIcon: const SvgListPicture(icon: "assets/icons/terms.svg"),
  ),
  Item(
    text: 'Privacy Policy',
    leadingIcon: const SvgListPicture(icon: "assets/icons/policy.svg"),
  ),
  Item(
    text: 'About',
    leadingIcon: const SvgListPicture(icon: "assets/icons/about.svg"),
  ),
  Item(
    text: 'Logout',
    leadingIcon: const SvgListPicture(icon: "assets/icons/logout.svg"),
  ),
];

class SvgListPicture extends StatelessWidget {
  final String icon;
  const SvgListPicture({
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: 17,
      width: 17,
    );
  }
}
