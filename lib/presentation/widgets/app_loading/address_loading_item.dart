import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/presentation/pages/address_pages/address/widgets/address_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddressLoadingItem extends StatelessWidget {
  const AddressLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: AddressItem(
        address: AddressEntity.fakeData,
      ),
    );
  }
}
