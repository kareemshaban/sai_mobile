import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class TabWidget extends StatelessWidget {
  final bool isActive;
  final String title;

  const TabWidget({super.key, required this.isActive, required this.title});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primary : ColorManager.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: isActive ? null : ColorManager.black.withOpacity(.7),
              fontSize: AppSize.s15(context),
            ),
        child: Text(title),
      ),
    );
  }
}
