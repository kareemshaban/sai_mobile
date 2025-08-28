import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/posts/search_post/widgets/search_post_user_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class UserNumbersBottomSheet extends GetView<ProfileController> {
  final String title;
  final String number;
  final ScrollController scrollController;
  final bool isVisitor;
  const UserNumbersBottomSheet({
    required this.title,
    required this.number,
    required this.scrollController,
    this.isVisitor = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      constraints: BoxConstraints(
        maxHeight: .9.h(context),
      ),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Obx(
        () => Column(
          children: [
            Text(
              "$title ($number)",
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            10.verticalSpace(),
            const Divider(height: 0),
            10.verticalSpace(),
            Flexible(
              child: controller.loadingUsers
                  ? const Center(child: AppLoader())
                  : controller.users.isEmpty
                      ? const EmptyDataWidget()
                      : ListView.separated(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return SearchPostUserItem(
                              user: controller.users[index],
                              isVisitor: isVisitor,
                            );
                          },
                          itemCount: controller.users.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 10.verticalSpace();
                          },
                        ),
            ),
            if (controller.loadingUsersPagination)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: AppLoader()),
              ),
            10.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
