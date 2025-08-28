import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/app_entity/app_search_entity.dart';
import 'package:new_sai/presentation/pages/posts/search_post/getx/search_post_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

import 'search_post_users_list.dart';
import 'search_post_videos_list.dart';

class SearchPostAllList extends GetView<SearchPostController> {
  final AppSearchEntity data;
  final bool loading;
  final int index;
  const SearchPostAllList(
      {super.key,
      required this.data,
      required this.loading,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: AppLoader())
        : Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomScrollView(
              slivers: [
                if ((index == 0 || index == 1)) ...[
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.only(bottom: 18),
                    sliver: Text(
                      AppStrings.video,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ).toSliver(),
                  ),
                  SearchPostVideosList(reels: data.videos),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 18),
                  ),
                ],
                if ((index == 0 || index == 2)) ...[
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.only(bottom: 18),
                    sliver: Text(
                      AppStrings.users,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ).toSliver(),
                  ),
                  SearchPostUsersList(users: data.users),
                ],
                if ((index == 0 || index == 3)) ...[
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.only(bottom: 18),
                    sliver: Text(
                      AppStrings.hashtags,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ).toSliver(),
                  ),
                  data.hashTags.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyDataWidget(),
                        )
                      : SliverList.separated(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              controller.tabController.animateTo(0);
                              controller.searchController.text =
                                  data.hashTags[index].split("#").last;
                              controller.onChangeCurrentIndex(0);
                              controller.search();
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary.withOpacity(.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.tag),
                                ),
                                20.horizontalSpace(),
                                Text(
                                  data.hashTags[index],
                                  style: Get.textTheme.titleLarge!.copyWith(
                                    fontSize: AppSize.s16(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              10.verticalSpace(),
                          itemCount: data.hashTags.length,
                        ),
                ],
              ],
            ),
          );
  }
}
