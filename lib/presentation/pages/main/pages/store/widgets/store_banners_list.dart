import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/banner_entity.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/banner_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoreBannersList extends GetView<StoreController> {
  const StoreBannersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingHomeData
          ? Skeletonizer(
              enabled: true,
              child: FlutterCarousel(
                items: [
                  BannerItem(banner: BannerEntity.fakeData),
                  BannerItem(banner: BannerEntity.fakeData),
                  BannerItem(banner: BannerEntity.fakeData),
                ],
                options: FlutterCarouselOptions(
                  height: 92,
                  viewportFraction: 1,
                  showIndicator: false,
                  autoPlay: true,
                ),
              ),
            )
          : Column(
              children: [
                if (controller.homeData.banners.isNotEmpty) ...[
                  14.verticalSpace(),
                  FlutterCarousel(
                    items: controller.homeData.banners
                        .map((e) => BannerItem(banner: e))
                        .toList(),
                    options: FlutterCarouselOptions(
                      height: 92,
                      viewportFraction: 1,
                      showIndicator: false,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
