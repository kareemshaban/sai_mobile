import 'package:flutter/material.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoomBannerLoadingItem extends StatelessWidget {
  const RoomBannerLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(),
      child: Container(
        width: 1.w(context),
        height: 75,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorManager.white,
        ),
      ),
    );
  }
}
