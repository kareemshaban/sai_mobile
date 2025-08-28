import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_gift_users_entity.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_gift_users_use_case.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class RoomGiftUsersBottomSheet extends StatefulWidget {
  final int roomID;
  const RoomGiftUsersBottomSheet({super.key, required this.roomID});

  @override
  State<RoomGiftUsersBottomSheet> createState() =>
      _RoomGiftUsersBottomSheetState();
}

class _RoomGiftUsersBottomSheetState extends State<RoomGiftUsersBottomSheet> {
  final controller = Get.find<RoomController>();
  final scrollController = ScrollController();
  final GetRoomGiftUsersUseCase _getRoomGiftUsersUseCase =
      instance<GetRoomGiftUsersUseCase>();
  int page = 1;
  List<RoomGiftUsersEntity> users = [];
  PaginationEntity pagination = PaginationModel().toDomain();
  bool isLoading = false;
  bool isLoadingPagination = false;

  getData({
    bool isPaginate = false,
  }) async {
    if (isPaginate) {
      isLoadingPagination = true;
    } else {
      isLoading = true;
      page = 1;
      users.clear();
    }
    setState(() {});
    (await _getRoomGiftUsersUseCase.execute({
      'id': widget.roomID,
      'page': page,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        users.addAll(r.data);
        pagination = r.pagination;
        page++;
      },
    );
    isLoading = false;
    isLoadingPagination = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !isLoadingPagination) {
          await getData(isPaginate: true);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.symmetric(vertical: 10),
      constraints: BoxConstraints(
        maxHeight: .6.h(context),
      ),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "${AppStrings.supporters} (${users.length})",
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
                10.verticalSpace(),
                const Divider(height: 0),
                10.verticalSpace(),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: users.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: isLoading
                          ? const AppLoader()
                          : const EmptyDataWidget(),
                    ),
                  )
                : SliverList.separated(
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return InkWell(
                        onTap: () => controller
                            .openProfileBottomSheet(user.fromId.toString()),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(52),
                              child: Image.network(
                                controller.getUserImage(
                                  user.fromId.toString(),
                                ),
                                errorBuilder: (context, error, stackTrace) {
                                  return const AppImage(
                                    image: Constants.userErrorWidget,
                                    width: 40,
                                    height: 40,
                                    isCircle: true,
                                  );
                                },
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            10.horizontalSpace(),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.userName,
                                    style: Get.textTheme.titleMedium!.copyWith(
                                      fontSize: AppSize.s16(context),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ID: ${user.referenceId}",
                                        style:
                                            Get.textTheme.titleMedium!.copyWith(
                                          fontSize: AppSize.s16(context),
                                        ),
                                      ),
                                      if (user.badges.isNotEmpty) ...[
                                        2.horizontalSpace(),
                                        PrivilegeDataView(
                                          url: user.badges.first,
                                          isBadges: true,
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            10.horizontalSpace(),
                            Text(
                              "${AppStrings.total} : ${user.totalPrice}",
                              style: Get.textTheme.displayLarge!.copyWith(
                                fontSize: AppSize.s14(context),
                              ),
                            ),
                            10.horizontalSpace(),
                            const AppIcon(
                              icon: IconsAssets.coins,
                              width: 15,
                              height: 15,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 10.verticalSpace(),
                    itemCount: users.length,
                  ),
          ),
          if (isLoadingPagination)
            const SliverPadding(
              padding: EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: AppLoader(),
              ),
            ),
        ],
      ),
    );
  }
}
