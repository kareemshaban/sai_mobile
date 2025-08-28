import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';

class StoryErrorWidget extends StatelessWidget {
  const StoryErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error_outline,
        color: ColorManager.white,
      ),
    );
  }
}
