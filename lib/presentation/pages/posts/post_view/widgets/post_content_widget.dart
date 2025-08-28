import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/stories_entity/post_data_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/video_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostContentWidget extends StatefulWidget {
  const PostContentWidget({super.key, required this.postDataEntity});
  final PostDataEntity postDataEntity;

  @override
  State<PostContentWidget> createState() => _PostContentWidgetState();
}

class _PostContentWidgetState extends State<PostContentWidget> {
  int currentIndex = 0;

  onPageChanged(value) {
    currentIndex = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 1.w(context),
            height: .75.h(context),
            child: PageView(
              onPageChanged: onPageChanged,
              children: _checkMediaType(),
            ),
          ),
        ),
        if (widget.postDataEntity.mediaPathList.length > 1) ...[
          20.verticalSpace(),
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            effect: ExpandingDotsEffect(
              dotColor: ColorManager.white.withOpacity(.5),
              activeDotColor: ColorManager.primary,
              dotWidth: 8,
              dotHeight: 8,
            ),
            count: widget.postDataEntity.mediaPathList.length,
          ),
          10.verticalSpace(),
        ],
      ],
    );
  }

  List<Widget> _checkMediaType() {
    return widget.postDataEntity.mediaPathList.map((e) {
      if (e.type == AssetType.video) {
        return VideoWidget(
          path: e.path,
          aspectRatio: 1080 / 1920,
        );
      }
      return Image.file(
        File(e.path),
      );
    }).toList();
  }
}
