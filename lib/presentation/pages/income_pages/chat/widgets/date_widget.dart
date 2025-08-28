import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "20 Sept 2024",
        style: Get.textTheme.titleSmall!.copyWith(
          fontSize: AppSize.s15(context),
        ),
      ),
    );
  }
}
