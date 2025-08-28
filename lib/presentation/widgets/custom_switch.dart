import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;

  const CustomSwitch({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 31,
      height: 16,
      child: Theme(
        data: ThemeData.light(useMaterial3: true),
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: ColorManager.white,
          activeTrackColor: ColorManager.primary,
          inactiveTrackColor: ColorManager.lightGreyColor.withOpacity(.5),
          inactiveThumbColor: ColorManager.white,
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          trackOutlineColor:
              const WidgetStatePropertyAll(ColorManager.transparent),
        ),
      ),
    );
  }
}
