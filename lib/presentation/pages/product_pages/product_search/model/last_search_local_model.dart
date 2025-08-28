import 'package:hive/hive.dart';
part 'last_search_local_model.g.dart';

@HiveType(typeId: 2)
class LastSearchLocalModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String name;

  LastSearchLocalModel({
    required this.id,
    required this.image,
    required this.name,
  });
}
