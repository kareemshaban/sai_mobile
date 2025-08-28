import 'package:new_sai/data/model/wallet_model/unit_model.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';

extension CharingUnitMapper on ChargingUnitModel? {
  ChargingUnitEntity toDomain() => ChargingUnitEntity(
      id: this?.id ?? 0,
      goldValue: this?.goldValue ?? "",
      unitValue: this?.unitValue ?? "");
}

extension UnitMapper on UnitModel? {
  UnitEntity toDomain() => UnitEntity(
      userGold: this?.userGold ?? 0,
      charginUnits: this?.charginUnits == null
          ? []
          : this!.charginUnits!.map((unit) => unit.toDomain()).toList(),
      banner: this?.banner == null
          ? ChargingUnitBannerModel().toDomain()
          : this!.banner.toDomain());
}

extension ChargingUnitBannerMapper on ChargingUnitBannerModel? {
  ChargingUnitBannerEntity toDomain() =>
      ChargingUnitBannerEntity(image: this?.image ?? "", url: this?.url ?? "");
}
