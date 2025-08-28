import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';

import 'vip_exclusive_privilege_item.dart';

class VipExclusivePrivilegeList extends GetView<VipController> {
  const VipExclusivePrivilegeList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        return VipExclusivePrivilegeItem(
          model: controller.premium.privileges[index],
          isActive: controller.premium.data[controller.currentIndex].privileges
              .contains(controller.premium.privileges[index].id),
        );
      },
      itemCount: controller.premium.privileges.length,
    );
  }
}
