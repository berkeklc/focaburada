// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';

class header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                print("Menu Clicked");
              },
              child: Image.asset(
                "images/icons/menu.png",
                color: Colors.black,
                height: 28,
                width: 28,
              ),
            ),
            /* InkWell(
              onTap: () {
                print("Profile Icon Clicked");
              },
              child: Image.asset(
                "images/icons/profile.png",
                height: 35,
                width: 35,
              ),
            ) */
          ],
        ),
    );
  }
}
