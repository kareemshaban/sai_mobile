import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class RoomOptionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const RoomOptionItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.6),
            size: 28,
          ),
          SizedBox(height: 3.0,),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodySmall!.copyWith(
              fontSize: AppSize.s14(context),
              color: Colors.white.withOpacity(0.6)
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
