import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_controller.dart';

import 'gallery_item.dart';

class AllItemsList extends GetView<GalleryController> {
  const AllItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        controller: controller.allScrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 0.8625,
        ),
        itemCount: controller.allPaths.length,
        itemBuilder: (context, index) {
          return GalleryItem(
            item: controller.allPaths[index],
            onTapItem: controller.onTapOnItem,
          );
        },
      ),
    );
  }
}
