import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:url_launcher/url_launcher.dart';

class CarousellWidget extends StatefulWidget {
  const CarousellWidget({super.key, required this.bannerEntity});
  final ChargingUnitBannerEntity bannerEntity;

  @override
  State<CarousellWidget> createState() => _CarousellWidgetState();
}

class _CarousellWidgetState extends State<CarousellWidget> {
  final carousellController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselView(
          onTap: (index) async {
            await launchUrl(
              Uri.parse(widget.bannerEntity.url),
              mode: LaunchMode.externalApplication,
            );
          },
          controller: carousellController,
          itemSnapping: true,
          itemExtent: double.infinity,
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                AppImage(
                  image: widget.bannerEntity.image,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                  isCircle: false,
                ),
                Center(
                    child: Text(
                  AppStrings.chargeWallet,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 24),
                ))
              ],
            )
          ]),
    );
  }
}
