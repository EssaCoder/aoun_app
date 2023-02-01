import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
        required this.controller,
        this.hintText,
        this.validator,
        this.keyboardType,
        this.onChanged,
        this.focusNode,
        this.readOnly,
        this.textAlign,
        this.onTap,
        this.obscureText,
        this.textDirection,
        this.prefixIcon,
        this.suffixIcon,
        this.textInputAction,
        this.maxLines})
      : super(key: key);
  final TextEditingController controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(hintText!=null)
        Text("$hintText",style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: SharedValues.padding),
        TextFormField(
          textInputAction: textInputAction,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textDirection: textDirection,
          controller: controller,
          readOnly: readOnly ?? false,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          onTap: onTap,
          focusNode: focusNode,
          textAlign: textAlign ?? TextAlign.start,
          style: Theme.of(context).textTheme.subtitle1,
          decoration: InputDecoration(
              contentPadding:
              Theme.of(context).inputDecorationTheme.contentPadding,prefixIcon: prefixIcon),
        ),
      ],
    );
  }
}
