import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/story_pages/my_story/getx/my_story_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';

class CommentArrowWidget extends StatefulWidget {
  const CommentArrowWidget({super.key});

  @override
  State<CommentArrowWidget> createState() => _CommentArrowWidgetState();
}

class _CommentArrowWidgetState extends State<CommentArrowWidget> {
  double padding = 0;
  final controller = Get.find<MyStoryController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        // onVerticalDragEnd: (details) {
        //   padding = 0;
        //   setState(() {});
        // },

        onTap: ()  {

        //  padding = 0;
          setState(() {});
      //   if (padding >= 25) {
            controller.storyController.pause();
             Get.toNamed(
              AppRoutes.myStoriesCommentAndViewsRoute,
              arguments: controller.story,
            );
    //   controller.storyController.play();
    // }
        },
        // onVerticalDragUpdate: (details) async {
        //   if (details.localPosition.dy <= -100) {
        //     padding = (details.localPosition.dy.abs()) / 10;
        //     if (padding >= 25) {
        //       controller.storyController.pause();
        //       await Get.toNamed(
        //         AppRoutes.myStoriesCommentAndViewsRoute,
        //         arguments: controller.story,
        //       );
        //       controller.storyController.play();
        //     }
        //     setState(() {});
        //   }
        // },
        child: Padding(
          padding: EdgeInsets.only(bottom: padding + 24),
          child: Icon(
            Icons.keyboard_arrow_up,
            color: ColorManager.white.withOpacity(.6),
            size: 70,
          ),
        ),
      ),
    );
  }
}
