import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/banner_entity.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerItem extends StatelessWidget {
  final BannerEntity banner;
  const BannerItem({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (banner.type == 'link') {
          if (!await launchUrl(
            Uri.parse(banner.typeVal),
            mode: LaunchMode.externalApplication,
          )) {
            log('Could not launch $banner.typeVal');
          }
        }
        if (banner.type == 'product') {
          Get.toNamed(AppRoutes.productDetailsRoute,
              arguments: int.parse(banner.typeVal));
        }
      },
      child: AppImage(
        image: banner.image,
        fit: BoxFit.cover,
        radius: 15,
        width: 1.w(context),
        height: 92,
      ),
    );
  }
}
