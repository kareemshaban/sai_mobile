import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/posts/search_post/getx/search_post_controller.dart';
import 'package:new_sai/presentation/pages/posts/search_post/widgets/search_post_all_list.dart';
import 'package:new_sai/presentation/pages/posts/search_post/widgets/search_post_tab_bar.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class SearchPostView extends GetView<SearchPostController> {
  const SearchPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: AppFormFiled(
          hint: AppStrings.search,
          controller: controller.searchController,
          hintTextColor: ColorManager.textGrey2,
          onSubmit: (value) {
            controller.search();
          },
          prefixIcon: InkWell(
            onTap: controller.search,
            child: const Icon(
              Icons.search,
              color: ColorManager.textGrey2,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SearchPostTabBar(),
          Expanded(
            child: Obx(
              () => controller.loading
                  ? const Center(child: AppLoader())
                  : controller.data.hashTags.isEmpty &&
                          controller.data.videos.isEmpty &&
                          controller.data.users.isEmpty
                      ? const EmptyDataWidget()
                      : TabBarView(
                          controller: controller.tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            4,
                            (index) {
                              return SearchPostAllList(
                                data: controller.data,
                                loading: controller.loading,
                                index: index,
                              );
                            },
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
