class CategoryEntity {
  int id;
  String name;
  String image;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  static final fakeData = CategoryEntity(id: 0, name: "name", image: "image");
}
