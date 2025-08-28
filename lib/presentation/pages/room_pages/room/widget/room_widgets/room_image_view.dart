import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class RoomImageView extends StatelessWidget {
  final String image;
  const RoomImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: AppBar(
        backgroundColor: ColorManager.black,
        leading: const AppBackButton(color: ColorManager.white),
      ),
      body: Center(
        child: AppImage(
          image: image,
          radius: 8,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
