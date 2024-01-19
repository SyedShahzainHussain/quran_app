import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isSelected;
  const Indicator({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(left: 5, right: 5),
      width: isSelected ? 50 : 30,
      height: 40,
      duration: const Duration(
        milliseconds: 150,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360.0),
        color: isSelected ? const Color(0xffee8f8b) : Colors.grey,
      ),
    );
  }
}
