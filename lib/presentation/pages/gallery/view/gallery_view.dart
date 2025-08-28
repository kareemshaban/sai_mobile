import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/stories_entity/post_data_entity.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_controller.dart';
import 'package:new_sai/presentation/pages/gallery/widgets/all_items_list.dart';
import 'package:new_sai/presentation/pages/gallery/widgets/gallery_tab_bar.dart';
import 'package:new_sai/presentation/pages/gallery/widgets/images_items_list.dart';
import 'package:new_sai/presentation/pages/gallery/widgets/videos_items_list.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.close),
          ),
          title: Text(AppStrings.gallery),
          bottom: const GalleryTabBar(),
        ),
        floatingActionButton: Obx(
          () => controller.selectedFilePaths.isEmpty
              ? const SizedBox()
              : AppButton(
                  title: AppStrings.next,
                  width: .7.w(context),
                  onTap: () => Get.offNamed(
                    AppRoutes.postViewRoute,
                    arguments: {
                      "isStory": controller.isStory,
                      "data": PostDataEntity(
                        mediaPathList: controller.selectedFilePaths,
                        textContent: "",
                      )
                    },
                  ),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: controller.loading
            ? const Center(child: AppLoader())
            : TabBarView(
                controller: controller.tabController,
                children: const [
                  AllItemsList(),
                  VideosItemsList(),
                  ImagesItemsList(),
                ],
              ),
      ),
    );
  }
}
