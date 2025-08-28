class SettingsMarketProductEntity {
  int id;
  String name;
  num goldPrice;
  String expirationDate;
  String image;
  String category;
  String productId;
  bool isBuy;
  bool isSelected;

  SettingsMarketProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.isSelected,
    required this.expirationDate,
    required this.goldPrice,
    required this.isBuy,
    required this.productId,
  });
}
