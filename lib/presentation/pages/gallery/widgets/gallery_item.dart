import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryItem extends StatefulWidget {
  final AssetEntity item;
  final void Function(SelectedPathsModel? path)? onTapItem;
  const GalleryItem({
    super.key,
    required this.item,
    this.onTapItem,
  });

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: widget.item.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return InkWell(
            onTap: () async {
              final file = await widget.item.file;
              if (widget.onTapItem != null) {
                widget.onTapItem!(SelectedPathsModel(
                    path: file?.path ?? "", type: widget.item.type));
                setState(() {});
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                ),
                Obx(
                  () {
                    log(Get.find<GalleryController>()
                        .selectedFilePaths
                        .length
                        .toString());
                    return FutureBuilder(
                        future: widget.item.file,
                        builder: (context, snapshot) {
                          final isSelected = Get.find<GalleryController>()
                              .selectedFilePaths
                              .where((element) =>
                                  element.path == snapshot.data?.path)
                              .isNotEmpty;
                          return PositionedDirectional(
                            top: 5,
                            end: 5,
                            child: Container(
                              padding: EdgeInsets.all(isSelected ? 2 : 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? ColorManager.primary : null,
                                border: Border.all(
                                  color: ColorManager.white.withOpacity(.2),
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check_outlined,
                                      color: ColorManager.white,
                                      size: 15,
                                    )
                                  : null,
                            ),
                          );
                        });
                  },
                ),
                if (widget.item.type == AssetType.video)
                  const PositionedDirectional(
                    bottom: 5,
                    start: 5,
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
              ],
            ),
          );
        }
        return Container(color: Colors.grey[300]);
      },
    );
  }
}
