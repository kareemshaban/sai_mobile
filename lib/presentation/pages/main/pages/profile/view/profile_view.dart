import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/profile_stories_list.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/profile_reels_list.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/profile_tab_bar.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/user_bio.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/user_buttons.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/user_cover_and_info_widget.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/user_numbers_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/reels_loading_list.dart';
import 'package:new_sai/presentation/widgets/app_loading/stories_loading_list.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/guest_dilaog.dart';
import 'package:new_sai/presentation/widgets/pull_to_refresh_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return isGuest()
        ? const GuestDilaog()
        : Obx(
            () => controller.loadingGetProfile
                ? const Center(child: AppLoader())
                : DefaultTabController(
                    length: 2,
                    child: PullToRefreshWidget(
                      scrollController: controller.scrollController,
                      onRefresh: () => controller.getAllInit(),
                      controller: controller.refreshController,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 575 + 40,
                            pinned: true,
                            bottom: const ProfileTabBar(),
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Column(
                                children: [
                                  const UserCoverAndInfoWidget(),
                                  24.verticalSpace(),
                                  const UserNumbersWidget(),
                                  24.verticalSpace(),
                                  const UserButtons(),
                                  14.verticalSpace(),
                                  const UserBio(),
                                  2.verticalSpace(),
                                  if (controller.loadingUserStories)
                                    const StoriesLoadingList()
                                  else
                                    ProfileStoriesList(
                                      scrollController:
                                          controller.userStoryController,
                                      stories: controller.userStories,
                                    ),
                                  6.verticalSpace(),
                                ],
                              ),
                            ),
                          ),
                          // SliverToBoxAdapter(
                          //   child: ElevatedButton(onPressed: (){
                          //     showSnackBarWidget(
                          //       textColor: Colors.black,
                          //       message:" r.message "?? "",
                          //       color: ColorManager.green.withOpacity(0.7),
                          //     );
                          //   }, child: Text("test")),
                          // ),
                          SliverFillRemaining(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                if (controller.loadingUserReels)
                                  const ReelsLoadingList()
                                else
                                  Column(
                                    children: [
                                      Expanded(
                                        child: controller.userReels.isEmpty
                                            ? const EmptyDataWidget()
                                            : ProfileReelsList(
                                                reels: controller.userReels,
                                                controller: controller
                                                    .userReelsController,
                                                onTapReels: (index) {
                                                  Get.toNamed(
                                                    AppRoutes
                                                        .usersAndSavedReelsRoute,
                                                    arguments: {
                                                      'title':
                                                          AppStrings.myReels,
                                                      'reels':
                                                          controller.userReels,
                                                      'initIndex': index,
                                                    },
                                                  );
                                                },
                                              ),
                                      ),
                                      if (controller.loadingUserReelsPagination)
                                        const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Center(
                                            child: AppLoader(),
                                          ),
                                        )
                                    ],
                                  ),
                                if (controller.loadingSavedReels)
                                  const ReelsLoadingList()
                                else
                                  Column(
                                    children: [
                                      Expanded(
                                        child: controller.savedReels.isEmpty
                                            ? const EmptyDataWidget()
                                            : ProfileReelsList(
                                                reels: controller.savedReels,
                                                controller: controller
                                                    .savedReelsController,
                                                onTapReels: (index) async {
                                                  await Get.toNamed(
                                                    AppRoutes
                                                        .usersAndSavedReelsRoute,
                                                    arguments: {
                                                      'title':
                                                          AppStrings.savedReels,
                                                      'reels':
                                                          controller.savedReels,
                                                      'initIndex': index,
                                                    },
                                                  );
                                                  await controller
                                                      .getSavedReels();
                                                },
                                              ),
                                      ),
                                      if (controller
                                          .loadingSavedReelsPagination)
                                        const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Center(
                                            child: AppLoader(),
                                          ),
                                        )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
  }
}
