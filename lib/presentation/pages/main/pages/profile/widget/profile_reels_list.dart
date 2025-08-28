import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';

import 'profile_reels_item.dart';

class ProfileReelsList extends StatelessWidget {
  final bool isScroll;
  final List<ReelsEntity> reels;
  final ScrollController? controller;
  final void Function(int index) onTapReels;
  const ProfileReelsList({
    this.isScroll = true,
    super.key,
    required this.reels,
    this.controller,
    required this.onTapReels,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: reels.length,
      controller: controller,
      shrinkWrap: !isScroll,
      physics: isScroll ? null : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 2),
      itemBuilder: (context, index) => ProfileReelsItem(
        model: reels[index],
        onTap: () => onTapReels(index),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.16,
      ),
    );
  }
}
