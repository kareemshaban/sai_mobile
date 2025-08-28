class GiftEntity {
  int id;
  GiftCategoryEntity category;
  String giftImg;
  String giftFile;
  num goldValue;

  GiftEntity({
    required this.id,
    required this.category,
    required this.giftImg,
    required this.giftFile,
    required this.goldValue,
  });
}

class GiftCategoryEntity {
  int id;
  String name;

  GiftCategoryEntity({
    required this.id,
    required this.name,
  });
}
