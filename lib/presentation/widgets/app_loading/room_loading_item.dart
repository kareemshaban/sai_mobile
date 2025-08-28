import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoomLoadingItem extends StatelessWidget {
  const RoomLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: RoomItemWidget(room: RoomEntity.fakeData),
    );
  }
}
