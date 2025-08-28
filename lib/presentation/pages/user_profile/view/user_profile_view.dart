import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/profile_reels_list.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/profile_stories_list.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_controller.dart';
import 'package:new_sai/presentation/pages/user_profile/widgets/user_profile_bio.dart';
import 'package:new_sai/presentation/pages/user_profile/widgets/user_profile_numbers_widget.dart';
import 'package:new_sai/presentation/pages/user_profile/widgets/user_profile_cover_and_info_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/reels_loading_list.dart';
import 'package:new_sai/presentation/widgets/app_loading/stories_loading_list.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/pull_to_refresh_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.loadingGetProfile
            ? const Center(child: AppLoader())
            : SafeArea(
                child: PullToRefreshWidget(
                  onRefresh: () => controller.initController(),
                  controller: RefreshController(),
                  scrollController: controller.userReelsController,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const UserProfileCoverAndInfoWidget(),
                      24.verticalSpace(),
                      const UserProfileNumbersWidget(),

                      // 24.verticalSpace(),
                      // const UserProfileButtons(),
                      14.verticalSpace(),
                      const UserProfileBio(),
                      20.verticalSpace(),
                      if ((controller.user.profile == "none" ||
                              controller.user.profile == "private") &&
                          !controller.user.isFriend)
                        Center(
                          child: Column(
                            children: [
                              Text(
                                AppStrings.thisAccountIsPrivate,
                                style: Get.textTheme.titleMedium!.copyWith(
                                  fontSize: AppSize.s20(context),
                                ),
                              ),
                              Text(
                                AppStrings
                                    .followThisAccountToSeeItsContentAndInteraction,
                                style: Get.textTheme.headlineMedium!.copyWith(
                                  fontSize: AppSize.s16(context),
                                ),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        if (controller.loadingUserStory) ...[
                          2.verticalSpace(),
                          const StoriesLoadingList(),
                          6.verticalSpace(),
                        ] else ...[
                          if (controller.userStory.isNotEmpty) ...[
                            2.verticalSpace(),
                            ProfileStoriesList(
                              isMyStory: false,
                              stories: controller.userStory,
                              scrollController: controller.userStoryController,
                            ),
                            6.verticalSpace(),
                          ],
                        ],


                        if (controller.loadingUserReels)
                          const ReelsLoadingList()
                        else
                          ProfileReelsList(
                            isScroll: false,
                            reels: controller.userReels,
                            onTapReels: (index) {
                              Get.toNamed(
                                AppRoutes.usersAndSavedReelsRoute,
                                arguments: {
                                  'title': controller.user.name,
                                  'reels': controller.userReels,
                                  'initIndex': index,
                                },
                              );
                            },
                          ),
                        if (controller.loadingUserReelsPagination)
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(child: AppLoader()),
                          ),
                      ]
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
