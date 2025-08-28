import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class VoiceMessageWidget extends StatefulWidget {
  final bool isSender;
  final MessagesEntity model;
  const VoiceMessageWidget(
      {super.key, required this.isSender, required this.model});

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget>
    with AutomaticKeepAliveClientMixin {
  final player = AudioPlayer();
  Duration duration = const Duration();
  Duration playDuration = const Duration();
  bool isPlay = false;
  final user = Get.find<AppController>().user;

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  initPlayer() async {

    final cache =
    await DefaultCacheManager().getFileFromCache(widget.model.file);
    if (cache == null) {
      final file =
      await DefaultCacheManager().downloadFile(widget.model.file);
      await DefaultCacheManager()
          .putFile(file.file.path, await file.file.readAsBytes());
      duration = await player
          .setAudioSource(AudioSource.file(file.file.path)) ??
          const Duration();
    } else {
      duration = await player
          .setAudioSource(AudioSource.file(cache.file.path)) ??
          const Duration();
    }

    player.playerStateStream.listen((event) {
      isPlay = event.playing;
      if (mounted) {
        setState(() {});
      }
    });
    player.positionStream.listen((event) {
      playDuration = event;
      if (playDuration.inSeconds == duration.inSeconds) {
        player.stop();
        player.seek(const Duration(seconds: 0));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      mainAxisAlignment:
          widget.isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.isSender) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.profileImg,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const AppImage(
                image: Constants.userErrorWidget,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
                isCircle: true,
              ),
            ),
          ),
          9.horizontalSpace(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: .7.w(context),
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.messageColor,
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: isPlay
                            ? () {
                                player.pause();
                              }
                            : () {
                                player.play();
                              },
                        child: Icon(
                          isPlay ? Icons.pause : Icons.play_arrow_rounded,
                          color: ColorManager.primary,
                          size: 25,
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 40,
                          child: Slider(
                            value: playDuration.inSeconds.toDouble(),
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            activeColor: ColorManager.primary,
                            inactiveColor: ColorManager.primary.withOpacity(.4),
                            thumbColor: ColorManager.primary,
                            onChanged: (value) {
                              player.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              2.verticalSpace(),
              Text(
                widget.model.createdAt,
                style: Get.textTheme.labelSmall!.copyWith(
                  fontSize: AppSize.s10(context),
                ),
              ),
            ],
          ),
        ] else ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: .7.w(context),
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.primary,
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: isPlay
                            ? () {
                                player.pause();
                              }
                            : () {
                                player.play();
                              },
                        child: Icon(
                          isPlay ? Icons.pause : Icons.play_arrow_rounded,
                          color: ColorManager.white,
                          size: 25,
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 40,
                          child: Slider(
                            value: playDuration.inSeconds.toDouble(),
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            activeColor: ColorManager.white,
                            inactiveColor: ColorManager.white.withOpacity(.4),
                            thumbColor: ColorManager.white,
                            onChanged: (value) {
                              player.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              2.verticalSpace(),
              Text(
                widget.model.createdAt,
                style: Get.textTheme.labelSmall!.copyWith(
                  fontSize: AppSize.s10(context),
                ),
              ),
            ],
          ),
          9.horizontalSpace(),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              widget.model.userInfo.logo,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const AppImage(
                image: Constants.userErrorWidget,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
                isCircle: true,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
