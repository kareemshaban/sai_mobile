import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class CountryItem extends StatelessWidget {
  final CountryEntity country;
  final Function(CountryEntity country) onTap;
  const CountryItem({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(country),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            AppImage(
              image: country.flag,
              width: 40,
              height: 25,
              fit: BoxFit.cover,
            ),
            10.horizontalSpace(),
            Text(
              country.name,
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
