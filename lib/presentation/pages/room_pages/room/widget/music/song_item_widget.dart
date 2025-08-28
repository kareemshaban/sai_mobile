import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_song_model.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class SongItemWidget extends StatelessWidget {
  final RoomSongModel song;
  final bool isPlay;
  final void Function()? onTapDelete;
  final void Function()? onTap;
  const SongItemWidget({
    super.key,
    required this.song,
    this.isPlay = false,
    this.onTapDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                image: song.image != null
                    ? DecorationImage(
                        image: MemoryImage(song.image!),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: CachedNetworkImageProvider(
                          Constants.musicIcon,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
              child: isPlay
                  ? Lottie.asset(
                      LottieAssets.pulse,
                      width: 25,
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSize.s16(context),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${AppStrings.duration}: ${durationText(Duration(seconds: song.duration ?? 0))}',
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s12(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: onTapDelete,
              child: const Icon(
                Icons.delete_outline,
                color: ColorManager.red,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
