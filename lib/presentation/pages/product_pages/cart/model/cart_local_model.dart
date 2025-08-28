import 'package:hive/hive.dart';
part 'cart_local_model.g.dart';

@HiveType(typeId: 1)
class CartLocalModel {
  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  num price;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  int minQuantity;
  @HiveField(5)
  int maxQuantity;
  @HiveField(6)
  List<int>? optionalOption;
  @HiveField(7)
  int? quantityOptionId;
  @HiveField(8)
  int id;

  CartLocalModel({
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.minQuantity,
    required this.maxQuantity,
    this.optionalOption,
    this.quantityOptionId,
    required this.id,
  });
}
