import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_image_view.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImages extends GetView<ProductDetailsController> {
  const ProductImages({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        tag: Get.arguments.toString(),
        builder: (controller) {
          return Obx(
            () => Column(
              children: [
                if (controller.loadingGetProduct) ...[
                  Skeletonizer(
                    enabled: true,
                    effect: const ShimmerEffect(),
                    child: FlutterCarousel(
                      items: List.generate(
                        1,
                        (index) {
                          return AppImage(
                            image: Constants.userErrorWidget,
                            width: 1.w(context),
                            height: 277,
                            radius: 10,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      options: FlutterCarouselOptions(
                        height: 277,
                        showIndicator: false,
                        viewportFraction: 1,
                      ),
                    ),
                  ),
                  17.verticalSpace(),
                ] else ...[
                  if (controller.product.images.isNotEmpty) ...[
                    FlutterCarousel(
                      items: List.generate(
                        controller.product.images.length,
                        (index) {
                          return InkWell(
                            onTap: () => Get.to(RoomImageView(
                              image: controller.product.images[index].imagePath,
                            )),
                            child: AppImage(
                              image: controller.product.images[index].imagePath,
                              width: 1.w(context),
                              height: 277,
                              radius: 10,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      options: FlutterCarouselOptions(
                        height: 277,
                        showIndicator: false,
                        viewportFraction: 1,
                        autoPlay: controller.product.images.length > 1,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          controller.cureentImageIndex = index;
                        },
                      ),
                    ),
                    if (controller.product.images.length > 1) ...[
                      10.verticalSpace(),
                      AnimatedSmoothIndicator(
                        activeIndex: controller.cureentImageIndex,
                        effect: ExpandingDotsEffect(
                          dotColor: ColorManager.black.withOpacity(.1),
                          activeDotColor: ColorManager.primary,
                          dotWidth: 8,
                          dotHeight: 8,
                        ),
                        count: controller.product.images.length,
                      ),
                    ],
                    17.verticalSpace(),
                  ],
                ],
              ],
            ),
          );
        });
  }
}
