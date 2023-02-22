import "package:flutter/material.dart";
import "package:food_delivery_app/util/dimensions.dart";

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.height=70,
      this.width=250,
      this.fontSize,
      this.radius = 5,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : Theme.of(context).primaryColor,
        minimumSize: Size(width == null ? Dimension.screenWidth : width!,
            height == null ? height! : Dimension.height10 * 5),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)));
    return Center(
      child: SizedBox(
        width: width ?? Dimension.screenWidth,
        height: height ?? Dimension.height10 * 5,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: Dimension.width10 / 2),
                      child: Icon(
                        icon,
                        color: transparent
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                      ),
                    )
                  : SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: fontSize != null ? fontSize : Dimension.font16,
                    color: transparent
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
