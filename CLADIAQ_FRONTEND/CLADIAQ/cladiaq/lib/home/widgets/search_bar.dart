import 'package:flutter/material.dart';

class CqSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      height: 25,
      width: 120,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 15),
          hintText: "Location...  ",
          prefixIcon: Icon(
            Icons.search,
            size: 15,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,

          // Leading search icon
        ),
      ),
    );
  }
}
