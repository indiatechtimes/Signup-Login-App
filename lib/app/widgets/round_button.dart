import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;

  final dynamic onTap;

  const RoundButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}
