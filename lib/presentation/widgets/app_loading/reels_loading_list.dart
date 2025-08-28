import 'package:flutter/material.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReelsLoadingList extends StatelessWidget {
  const ReelsLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 2),
      itemBuilder: (context, index) => const Skeletonizer(
        enabled: true,
        child: AppImage(
          image: Constants.userErrorWidget,
          fit: BoxFit.cover,
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.16,
      ),
    );
  }
}
