import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/widgets/my_own_rank_bottom_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/widgets/rank_rooms_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/widgets/rank_top_rooms_list.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/widgets/top_rooms_filter_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/widgets/top_rooms_tabs.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class TopRoomView extends GetView<TopRoomsController> {
  const TopRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(AppStrings.rank),
      ),
      body: Column(
        children: [
          const TopRoomsFilterWidget(),
          const TopRoomsTabs(),
          Expanded(
            child: Obx(
              () => TabBarView(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  4,
                  (index) {
                    if (controller.loadingGlobal) {
                      return const Center(child: AppLoader());
                    } else {
                      return const Column(
                        children: [
                          RankRoomsWidget(),
                          // SizedBox(
                          //   height: 20
                          // ),
                          RankTopRoomsList(),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyOwnRankBottomWidget(),
    );
  }
}
