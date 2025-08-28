import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/country_rooms_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CountryRoomsLoadingItem extends StatelessWidget {
  const CountryRoomsLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CountryRoomsItem(country: CountryEntity.fakeData),
    );
  }
}
