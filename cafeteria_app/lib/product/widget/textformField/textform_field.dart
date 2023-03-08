import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/color/colors.dart';
import '../../constant/decoration/textformDeco/textform_decoration.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    required this.validator,
    this.labelText,
    super.key,
    this.keyboardType,
    required this.maxLength,
    this.controller,
    this.mainIcon,
    this.onPressed,
  });
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final int maxLength;
  final String? labelText;

  final TextEditingController? controller;
  final VoidCallback? onPressed;
  final IconData? mainIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      maxLength: maxLength,
      cursorColor: AppColors.darkGrey,
      decoration:
          PaymentTextFieldDecoration(context, labelText!, mainIcon, onPressed),
      validator: validator,
    );
  }
}
