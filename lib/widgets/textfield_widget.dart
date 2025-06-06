import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/library.dart';

class TextFieldCubit extends Cubit<bool> {
  TextFieldCubit() : super(true); // default is obscure = true

  void toggleVisibility() => emit(!state);
}

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? label;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final int maxLines;
  final Color fillColor;
  final Color borderColor;
  final Color labelColor;
  final bool isrequired;
  final int labelfontSize;
  final bool readonly;
  final double borderRadius;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.readonly = false,
    this.prefixIcon,
    this.isrequired = false,
    this.fillColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.controller,
    this.labelColor = AppColors.textColorWhite,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.labelfontSize = 16,
    this.borderRadius=50,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisStart,
      children: [
        // if (label != null)
        //   RichText(
        //     text: TextSpan(children: [
        //       TextSpan(
        //         text: label!,
        //         style: context.bodyMedium!.copyWith(
        //             color: labelColor,
        //             fontWeight: FontWeight.normal,
        //             fontSize: labelfontSize.toDouble()),
        //       ),
        //       if (isrequired)
        //         TextSpan(
        //           text: "*",
        //           style: context.bodyMedium!.copyWith(
        //               color: Colors.red,
        //               fontWeight: FontWeight.bold,
        //               fontSize: labelfontSize.toDouble()),
        //         ),
        //     ]),
        //   ),
        // SizedBox(
        //   height: 5,
        // ),
        obscureText
            ? BlocBuilder<TextFieldCubit, bool>(
                builder: (context, isObscure) {
                  return _buildTextField(context, isObscure);
                },
              )
            : _buildTextField(context, false),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, bool isObscure) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      readOnly: readonly,
      style: context.bodySmall,
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      decoration: InputDecoration(
        hintStyle: context.bodySmall!.copyWith(color: AppColors.lightGrey),
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.lightGrey,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        contentPadding:
            EdgeInsets.only(left: 20, top: maxLines > 1 ? 20 : 17, bottom: 17),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        fillColor: fillColor,
        filled: true,
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.lightGrey,
                ),
                onPressed: () =>
                    context.read<TextFieldCubit>().toggleVisibility(),
              )
            : null,
      ),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
