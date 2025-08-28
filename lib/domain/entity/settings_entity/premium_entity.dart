class PremiumEntity {
  List<PrivilegesPremiumEntity> privileges;
  List<PremiumDataEntity> data;
  num totalCount;
  String type;
  num isExpierd;
  num duration;
  num categoryId;

  PremiumEntity({
    required this.type,
    required this.data,
    required this.privileges,
    required this.categoryId,
    required this.duration,
    required this.isExpierd,
    required this.totalCount,
  });
}

class PrivilegesPremiumEntity {
  int id;
  String name;
  String description;
  String icon;

  PrivilegesPremiumEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

class PremiumDataEntity {
  int id;
  String name;
  String badge;
  num activationPrice;
  num renewalPrice;
  List<int> privileges;
  int count;

  PremiumDataEntity({
    required this.name,
    required this.id,
    required this.privileges,
    required this.activationPrice,
    required this.badge,
    required this.count,
    required this.renewalPrice,
  });
}
