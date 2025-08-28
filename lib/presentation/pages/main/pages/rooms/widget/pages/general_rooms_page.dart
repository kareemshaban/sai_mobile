import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/country_rooms_item.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_banner_item.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_item_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/country_rooms_loading_item.dart';
import 'package:new_sai/presentation/widgets/app_loading/room_banner_loading_item.dart';
import 'package:new_sai/presentation/widgets/app_loading/room_loading_item.dart';

import '../../../../../game/view/game_page.dart';

class GeneralRoomsPage extends GetView<RoomsController> {
  const GeneralRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          20.verticalSpace(),
          if (controller.loadingCountry) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.browseByCountries,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s16(context),
                    ),
                  ),
                  Text(
                    AppStrings.all,
                    style: Get.textTheme.displayLarge!.copyWith(
                      fontSize: AppSize.s14(context),
                      fontWeight: FontWeightManger.semiBold,
                    ),
                  ),
                ],
              ),
            ),
            15.verticalSpace(),
            SizedBox(
              height: 67,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    const CountryRoomsLoadingItem(),
                separatorBuilder: (context, index) => 10.horizontalSpace(),
                itemCount: 10,
              ),
            ),
            16.verticalSpace(),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.browseByCountries,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s16(context),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(
                      AppRoutes.countryRoomRoute,
                      arguments: controller.countries.first,
                    ),
                    child: Text(
                      AppStrings.all,
                      style: Get.textTheme.displayLarge!.copyWith(
                        fontSize: AppSize.s14(context),
                        fontWeight: FontWeightManger.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            15.verticalSpace(),
            SizedBox(
              height: 70,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CountryRoomsItem(
                  country: controller.countries[index],
                  onTap: () => Get.toNamed(
                    AppRoutes.countryRoomRoute,
                    arguments: controller.countries[index],
                  ),
                ),
                separatorBuilder: (context, index) => 10.horizontalSpace(),
                itemCount: controller.countries.length,
              ),
            ),
            16.verticalSpace(),
          ],
          if (controller.loadingGetBanners) ...[
            FlutterCarousel(
              items: List.generate(
                3,
                (index) => const RoomBannerLoadingItem(),
              ),
              options: FlutterCarouselOptions(
                height: 75,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                autoPlay: true,
                showIndicator: true,
                slideIndicator: CircularSlideIndicator(
                  slideIndicatorOptions: const SlideIndicatorOptions(
                    indicatorRadius: 4,
                    enableAnimation: true,
                    itemSpacing: 12,
                  ),
                ),
              ),
            ),
            16.verticalSpace(),
          ] else ...[
            if (controller.topSenders.isNotEmpty ||
                controller.topBillionares.isNotEmpty ||
                controller.topRooms.isNotEmpty) ...[
              FlutterCarousel(
                items: [
                  ...List.generate(
                    controller.topRooms.length,
                    (index) {
                      return RoomBannerItem(
                        color: ColorManager.topRoomsColor,
                        title: AppStrings.topRooms,
                        banner: controller.topRooms[index],
                      );
                    },
                  ),
                  ...List.generate(
                    controller.topBillionares.length,
                    (index) {
                      return RoomBannerItem(
                        color: ColorManager.topBillionaireColor,
                        title: AppStrings.topBillionaire,
                        banner: controller.topBillionares[index],
                      );
                    },
                  ),
                  ...List.generate(
                    controller.topSenders.length,
                    (index) {
                      return RoomBannerItem(
                        color: ColorManager.topSenderColor,
                        title: AppStrings.topSenders,
                        banner: controller.topSenders[index],
                      );
                    },
                  ),
                ],
                options: FlutterCarouselOptions(
                  height: 75,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  showIndicator: false,
                ),
              ),
              16.verticalSpace(),
            ],
          ],
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.getGeneralPage(),
              child: CustomScrollView(
                controller: controller.famousScrollController,
                slivers: [
                  controller.loadingFamousRooms
                      ? SliverPadding(
                          padding: const EdgeInsets.only(
                              bottom: 20, right: 16, left: 16),
                          sliver: SliverList.separated(
                            itemBuilder: (context, index) =>
                                const RoomLoadingItem(),
                            separatorBuilder: (context, index) =>
                                5.verticalSpace(),
                            itemCount: 5,
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.only(
                              bottom: 20, right: 16, left: 16),
                          sliver: SliverList.separated(
                            itemBuilder: (context, index) => RoomItemWidget(
                              room: controller.famousRooms[index],
                              isTop: index == 0 || index == 1 || index == 2,
                              topNumber: (index + 1).toString(),
                            ),
                            separatorBuilder: (context, index) =>
                                5.verticalSpace(),
                            itemCount: controller.famousRooms.length,
                          ),
                        ),
                  if (controller.loadingFamousRoomsPagination)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: AppLoader(),
                      ),
                    ).toSliver(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
