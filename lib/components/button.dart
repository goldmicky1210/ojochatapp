import 'package:flutter/material.dart';
import 'package:ojochat_app/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 80.0,
    this.height = 40.0,
    this.backgroundColor = AppColors.DANGER_COLOR,
    this.textColor = Colors.white,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),

            // padding: MaterialStateProperty.all<EdgeInsets>(
            //   EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            // ),
            // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
        ));
  }
}
