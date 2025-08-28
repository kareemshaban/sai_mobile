import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/svga_player.dart';

class PrivilegeDataView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit fit;
  final Widget? errorWidget;
  final bool isCircle;
  final bool isBadges;
  const PrivilegeDataView({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.radius,
    this.isCircle = false,
    this.isBadges = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Get.find<AppController>().isVipActive()) {
      return getDataWidget();
    }
    if (isBadges) {
      return getDataWidget();
    }
    return const SizedBox();
  }

  Widget getDataWidget() {
    if (url.isEmpty) {
      return const SizedBox();
    }
    if (url.split(".").last == 'svga') {
      return SvgaPlayerWidget(
        url: url,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return AppImage(
        image: url,
        width: width,
        height: height,
        fit: fit,
        radius: radius,
        errorWidget: errorWidget,
        isCircle: isCircle,
      );
    }
  }
}
