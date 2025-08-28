import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class SearchPostVideoItem extends StatelessWidget {
  final ReelsEntity reel;
  const SearchPostVideoItem({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.black.withOpacity(.2),
              borderRadius: BorderRadius.circular(8),
              image: reel.media.isNotEmpty
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(reel.media.first.url),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
        const Center(
          child: Icon(
            Icons.play_arrow_rounded,
            color: ColorManager.white,
            size: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: Image.network(
                  reel.user.logo,
                  width: 17,
                  height: 17,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const AppImage(
                      image: Constants.userErrorWidget,
                      width: 17,
                      height: 17,
                      isCircle: true,
                    );
                  },
                ),
              ),
              3.horizontalSpace(),
              Text(
                reel.user.name,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s10(context),
                ),
              ),
              const Spacer(),
              const AppIcon(
                icon: IconsAssets.playButtonStroke,
                color: ColorManager.white,
                width: 10,
                height: 10,
              ),
              2.horizontalSpace(),
              Text(
                "${reel.countViews}",
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s10(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
