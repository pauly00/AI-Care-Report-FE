import 'package:flutter/material.dart';
import 'package:safe_hi/util/responsive.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;

  const DefaultAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      color: const Color(0xFFFFF6F6),
      padding: EdgeInsets.symmetric(vertical: responsive.itemSpacing),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment:
                  title == "안심하이" ? Alignment.centerLeft : Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logoicon.png',
                    width: responsive.iconSize,
                    height: responsive.iconSize,
                  ),
                  SizedBox(width: responsive.itemSpacing / 2),
                  Text(
                    title,
                    style: TextStyle(
                      color: title == "안심하이"
                          ? const Color(0xFFFB5457)
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.fontLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
