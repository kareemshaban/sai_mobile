class ChargingUnitEntity {
  final num id;
  final String goldValue;
  final String unitValue;
  ChargingUnitEntity(
      {required this.id, required this.goldValue, required this.unitValue});
}

class UnitEntity {
  final List<ChargingUnitEntity> charginUnits;

  final num userGold;
  final ChargingUnitBannerEntity banner;

  UnitEntity(
      {required this.charginUnits,
      required this.userGold,
      required this.banner});
}

class ChargingUnitBannerEntity {
  final String image;
  final String url;

  ChargingUnitBannerEntity({required this.image, required this.url});
}
