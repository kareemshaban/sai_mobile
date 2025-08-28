class ProductOptionEntity {
  int id;
  String name;
  String type;
  num price;
  List<ProductOptionValuesEntity> values;

  ProductOptionEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.values,
  });
}

class ProductOptionValuesEntity {
  int id;
  String name;

  ProductOptionValuesEntity({
    required this.id,
    required this.name,
  });
}
