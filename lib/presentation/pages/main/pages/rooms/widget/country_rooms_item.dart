import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class CountryRoomsItem extends StatelessWidget {
  final CountryEntity country;
  final void Function()? onTap;
  const CountryRoomsItem({
    super.key,
    required this.country,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          AppImage(
            image: country.flag,
            width: 50,
            height: 50,
            isCircle: true,
            fit: BoxFit.cover,
          ),
          5.verticalSpace(),
          Text(
            country.name,
            style: Get.textTheme.titleLarge!.copyWith(
              fontSize: AppSize.s10(context),
            ),
          ),
        ],
      ),
    );
  }
}
