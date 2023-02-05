import 'package:flutter/material.dart';
import '/views/shared/shared_values.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {Key? key, this.onPressed, this.minWidth, this.height, this.child, this.color, this.shape, this.progressColor, this.elevation})
      : super(key: key);
  final Function()? onPressed;
  final double? minWidth;
  final double? height;
  final double? elevation;
  final Widget? child;
  final Color? color;
  final Color? progressColor;
  final ShapeBorder? shape;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        isLoading = true;
        if (mounted) setState(() {});
        if (widget.onPressed != null) {
          await widget.onPressed!();
        }
        isLoading = false;
        if (mounted) setState(() {});
      },
      height: widget.height ?? 55,
      padding: EdgeInsets.zero,
      elevation: widget.elevation,
      minWidth: widget.minWidth,
      color: widget.color??Theme.of(context).primaryColor,
      shape: widget.shape??OutlineInputBorder(
          borderRadius: BorderRadius.circular(SharedValues.borderRadius),
      borderSide: BorderSide.none),
      child: Builder(
        builder: (context) {
          if (isLoading) {
            return CircularProgressIndicator(
              color: widget.progressColor??Theme.of(context).colorScheme.background,
            );
          }
          return widget.child?? const SizedBox.shrink();
        }
      ),
    );
  }
}
