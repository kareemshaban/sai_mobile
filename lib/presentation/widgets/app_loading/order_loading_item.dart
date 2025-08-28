import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/store_entity/order_entity.dart';
import 'package:new_sai/presentation/pages/product_pages/orders/widget/order_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderLoadingItem extends StatelessWidget {
  const OrderLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: OrderWidget(order: OrderEntity.fakeData),
    );
  }
}
