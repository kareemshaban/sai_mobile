import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class IncomeAppBar extends GetView<IncomeController>
    implements PreferredSizeWidget {
  const IncomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return isGuest()
        ? AppBar()
        : AppBar(
            title: Obx(
              () => InkWell(
                onTap: () => Get.find<MainController>().onChangeCurrentIndex(4),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            controller.appController.user.profileImg,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const AppImage(
                              image: Constants.userErrorWidget,
                              width: 50,
                              height: 50,
                              isCircle: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        PrivilegeDataView(
                          url: controller.appController.user.privileges.data
                              .profileFrame.file,
                          width: 60,
                          height: 60,
                          isCircle: true,
                        )
                      ],
                    ),
                    10.horizontalSpace(),
                    Text(controller.appController.user.name),
                  ],
                ),
              ),
            ),
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.searchPostRoute);
                },
                child: const Icon(
                  Icons.search,
                  color: ColorManager.primary,
                  size: 24,
                ),
              ),
              16.horizontalSpace(),
            ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
