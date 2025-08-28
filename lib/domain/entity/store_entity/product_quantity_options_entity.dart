class ProductQuantityOptionEntity {
  int quantityOptionId;
  List<ProductQuantityOptionValueEntity> optionValueId;
  num qnt;
  num buyPrice;
  num minOrderQnt;
  num maxOrderQnt;

  ProductQuantityOptionEntity({
    required this.quantityOptionId,
    required this.optionValueId,
    required this.qnt,
    required this.buyPrice,
    required this.minOrderQnt,
    required this.maxOrderQnt,
  });
}

class ProductQuantityOptionValueEntity {
  int option;
  int value;

  ProductQuantityOptionValueEntity({
    required this.option,
    required this.value,
  });
}
