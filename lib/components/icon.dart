import 'package:flutter/material.dart';
import 'package:ojochat_app/constants/app_colors.dart';

class CustomIcon extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final double iconSize;
  final IconData iconData;
  const CustomIcon({
    Key? key,
    required this.iconData,
    this.color = AppColors.COLOR_WHITE,
    this.backgroundColor = AppColors.PRIMARY_COLOR,
    this.iconSize = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(iconData),
        iconSize: iconSize,
        color: color,
        onPressed: () {},
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}
