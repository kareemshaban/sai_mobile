import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/best_seller_list.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/category_list.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/store_banners_list.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/store_location_widget.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/store_search_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getHomeData(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          const StoreSearchFiled(),
          17.verticalSpace(),
          if (!isGuest()) ...[
            const StoreLocationWidget(),
            17.verticalSpace(),
          ],
          const StoreBannersList(),
          const CategoryList(),
          const BestSellerList(),
        ],
      ),
    );
  }
}
