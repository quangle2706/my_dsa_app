import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final double width;
  final double height;
  final double borderRadius;

  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.backgroundColor,
    required this.iconColor,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
