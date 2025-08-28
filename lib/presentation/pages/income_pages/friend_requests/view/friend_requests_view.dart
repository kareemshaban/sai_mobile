import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/income_pages/friend_requests/getx/friend_requests_controller.dart';
import 'package:new_sai/presentation/pages/income_pages/friend_requests/widget/friend_request_item.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/pull_to_refresh_widget.dart';

class FriendRequestsView extends GetView<FriendRequestsController> {
  const FriendRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(AppStrings.friendRequests),
      ),
      body: Obx(
        () => controller.loadingRequest
            ? const Center(child: AppLoader())
            : PullToRefreshWidget(
                controller: controller.refreshController,
                scrollController: controller.scrollController,
                onRefresh: () => controller.getFriendRequest(),
                child: controller.requests.isEmpty
                    ? const EmptyDataWidget()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        itemBuilder: (context, index) => FriendRequestItem(
                          model: controller.requests[index],
                          onTapAccept: () => controller.acceptFriendRequest(
                              controller.requests[index].id),
                          onTapRemove: () => controller.removeFriendRequest(
                              controller.requests[index].id.toInt()),
                        ),
                        separatorBuilder: (context, index) =>
                            15.verticalSpace(),
                        itemCount: controller.requests.length,
                      ),
              ),
      ),
    );
  }
}
