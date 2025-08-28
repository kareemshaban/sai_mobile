import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_controller.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/pull_to_refresh_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'income_item_widget.dart';

class IncomeList extends GetView<IncomeController> {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.loadingConv) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            itemBuilder: (context, index) {
              return Skeletonizer(
                effect: const ShimmerEffect(),
                enabled: true,
                child: IncomeItemWidget(
                  model: MyConversationsEntity.fakeData,
                ),
              );
            },
            separatorBuilder: (context, index) => 15.verticalSpace(),
            itemCount: 4,
          );
        }

        if (controller.myConversations.isEmpty) {
          return const EmptyDataWidget();
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          itemBuilder: (context, index) {
            return Obx(() => IncomeItemWidget(
                  model: controller.myConversations[index],
                ));
          },
          separatorBuilder: (context, index) => 15.verticalSpace(),
          itemCount: controller.myConversations.length,
        );
      },
    );
  }
}
