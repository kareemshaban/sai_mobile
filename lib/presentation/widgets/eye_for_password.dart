import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';

class EyeForPassword extends StatelessWidget {
  final bool isPassword;
  final void Function()? onTap;
  const EyeForPassword({required this.isPassword, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isPassword ? Icons.visibility : Icons.visibility_off,
        color: ColorManager.textGrey,
        size: 20,
      ),
    );
  }
}
