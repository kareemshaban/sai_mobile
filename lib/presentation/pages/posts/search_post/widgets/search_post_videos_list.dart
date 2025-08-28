import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/presentation/pages/posts/search_post/getx/search_post_controller.dart';
import 'package:new_sai/presentation/pages/posts/search_post/widgets/search_post_video_item.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class SearchPostVideosList extends GetView<SearchPostController> {
  final List<ReelsEntity> reels;
  const SearchPostVideosList({super.key, required this.reels});

  @override
  Widget build(BuildContext context) {
    return reels.isEmpty
        ? const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyDataWidget(),
          )
        : SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.753,
              mainAxisSpacing: 10,
              crossAxisSpacing: 13,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.usersAndSavedReelsRoute,
                    arguments: {
                      'title': controller.searchController.text,
                      'reels': reels,
                      'initIndex': index,
                    },
                  );
                },
                child: SearchPostVideoItem(
                  reel: reels[index],
                ),
              );
            },
            itemCount: reels.length,
          );
  }
}
