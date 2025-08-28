class BannerEntity {
  String image;
  String type;
  String typeVal;

  BannerEntity({
    required this.image,
    required this.type,
    required this.typeVal,
  });

  static final fakeData =
      BannerEntity(image: "image", type: "type", typeVal: "typeVal");
}
