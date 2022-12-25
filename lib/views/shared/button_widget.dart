import 'package:flutter/material.dart';
import '/views/shared/shared_values.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, this.onPressed, this.minWidth, this.height, this.child})
      : super(key: key);
  final VoidCallback? onPressed;
  final double? minWidth;
  final double? height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: height ?? 55,
      padding: EdgeInsets.zero,
      minWidth: minWidth,
      color: Theme.of(context).primaryColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SharedValues.borderRadius),
      borderSide: BorderSide.none),
      child: child,
    );
  }
}
