import 'package:flutter/material.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoriesLoadingList extends StatelessWidget {
  const StoriesLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const Skeletonizer(
          enabled: true,
          child: AppImage(
            image: Constants.userErrorWidget,
            height: 65,
            width: 65,
            isCircle: true,
          ),
        ),
        separatorBuilder: (context, index) => 10.horizontalSpace(),
        itemCount: 5,
      ),
    );
  }
}
