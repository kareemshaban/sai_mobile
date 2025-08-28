import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FileMessageWidget extends StatefulWidget {
  final bool isSender;
  final MessagesEntity model;
  const FileMessageWidget(
      {super.key, required this.isSender, required this.model});

  @override
  State<FileMessageWidget> createState() => _FileMessageWidgetState();
}

class _FileMessageWidgetState extends State<FileMessageWidget> {
  double progress = 0;
  bool startDownload = false;
  final user = Get.find<AppController>().user;

  openFile() async {
    if (await checkIfFileDownloaded()) {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${widget.model.file.split("/").last}';
      OpenFilex.open(path);
    } else {
      downloadFile();
    }
  }

  downloadFile() async {
    try {
      startDownload = true;
      setState(() {});
      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${widget.model.file.split("/").last}';

      // if (!kReleaseMode) {
      //   dio.interceptors.add(PrettyDioLogger(
      //       requestHeader: true, requestBody: true, responseHeader: true));
      // }

      await dio.download(
        widget.model.file,
        path,
        onReceiveProgress: (count, total) {
          progress = count / total;
          setState(() {});
        },
      );
      startDownload = false;
      setState(() {});
      openFile();
    } catch (e) {
      startDownload = false;
      setState(() {});
      log(e.toString());
    }
  }

  Future<bool> isFileValid(String url) async {
    final dir = await getApplicationDocumentsDirectory();
    final fileName = url.split("/").last;
    final filePath = "${dir.path}/$fileName";
    final file = File(filePath);
    if (await file.exists()) {
      final dio = Dio();
      final response = await dio.head(url);
      final expectedFileSize =
          response.headers.value(HttpHeaders.contentLengthHeader);

      if (expectedFileSize != null &&
          await file.length() == int.parse(expectedFileSize)) {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkIfFileDownloaded() async {
    if (await isFileValid(widget.model.file)) {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${widget.model.file.split("/").last}';
      return File(path).exists();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
              InkWell(
                onTap: openFile,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: .7.w(context),
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.messageColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.primary.withOpacity(.2),
                        ),
                        child: const AppIcon(
                          icon: IconsAssets.file,
                          color: ColorManager.primary,
                        ),
                      ),
                      10.horizontalSpace(),
                      Flexible(
                        child: Text(
                          widget.model.file.split("/").last,
                          style: Get.textTheme.displayMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                      ),
                      10.horizontalSpace(),
                      if (startDownload)
                        CircularProgressIndicator(
                          value: progress,
                          color: ColorManager.primary,
                          backgroundColor: ColorManager.primary.withOpacity(.4),
                        )
                      else
                        FutureBuilder(
                          future: checkIfFileDownloaded(),
                          builder: (context, snapshot) {
                            if (snapshot.data == false) {
                              return InkWell(
                                onTap: downloadFile,
                                child: const Icon(
                                  Icons.arrow_downward,
                                  color: ColorManager.primary,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
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
              InkWell(
                onTap: openFile,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: .7.w(context),
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.primary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.white.withOpacity(.2),
                        ),
                        child: const AppIcon(
                          icon: IconsAssets.file,
                          color: ColorManager.white,
                        ),
                      ),
                      10.horizontalSpace(),
                      Flexible(
                        child: Text(
                          widget.model.file.split("/").last,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                      ),
                      10.horizontalSpace(),
                      if (startDownload)
                        CircularProgressIndicator(
                          value: progress,
                          color: ColorManager.white,
                          backgroundColor: ColorManager.white.withOpacity(.4),
                        )
                      else
                        FutureBuilder(
                          future: checkIfFileDownloaded(),
                          builder: (context, snapshot) {
                            if (snapshot.data == false) {
                              return InkWell(
                                onTap: downloadFile,
                                child: const Icon(
                                  Icons.arrow_downward,
                                  color: ColorManager.white,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
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
}
