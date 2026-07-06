import 'package:cladiaq/about/about.dart';
import 'package:cladiaq/about/privacypolicy.dart';
import 'package:cladiaq/about/termsandconditions.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/news/news.dart';
import 'package:cladiaq/settings/settings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cladiaq/notification/notification.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight(context) * 0.6,
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.white),
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    leading: item.leadingIcon,
                    title: Text(item.text),
                    trailing: SvgPicture.asset(
                      "assets/icons/arrow_right.svg",
                      height: 17,
                      width: 17,
                    ),
                    onTap: () {
                      // Handle item tap
                      if (index == 0) {
                      } else if (index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationCq()));
                      } else if (index == 2) {
                      } else if (index == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsCondition()));
                      } else if (index == 4) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPoliy()));
                      } else if (index == 5) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AboutCq()));
                      }
                    },
                  ),
                );
              },
            ),
          ),
          // const Divider(
          //   color: Colors.grey,
          //   height: 1,
          // )
        ],
      ),
    );
  }
}
