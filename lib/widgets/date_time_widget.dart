import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;
  final Function()? onTap;

  const DateTimeWidget(
      {super.key, required this.title, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyleOne),
          const Gap(6),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      IconButton(onPressed: onTap, icon: Icon(icon)),
                      // const Gap(1),
                      Expanded(child: Text(text))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
