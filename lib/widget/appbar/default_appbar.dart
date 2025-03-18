import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;

  const DefaultAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF6F6),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    title,
                    style: TextStyle(
                      color:
                          title == "안심하이"
                              ? const Color(0xFFFB5457)
                              : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
