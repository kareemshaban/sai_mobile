import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_controller.dart';

import 'gallery_item.dart';

class ImagesItemsList extends GetView<GalleryController> {
  const ImagesItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        controller: controller.imageScrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 0.8625,
        ),
        itemCount: controller.imagePaths.length,
        itemBuilder: (context, index) {
          return GalleryItem(
            item: controller.imagePaths[index],
            onTapItem: controller.onTapOnItem,
          );
        },
      ),
    );
  }
}
