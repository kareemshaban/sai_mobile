class UniqueIdEntity {
  int id;
  String name;
  String categoryIcon;
  String categoryDescription;
  List<UniqueSubCategoryEntity> subcategories;

  UniqueIdEntity({
    required this.id,
    required this.name,
    required this.categoryIcon,
    required this.categoryDescription,
    required this.subcategories,
  });
}

class UniqueSubCategoryEntity {
  int id;
  String name;
  List<PatternsEntity> patterns;

  UniqueSubCategoryEntity({
    required this.id,
    required this.name,
    required this.patterns,
  });
}

class PatternsEntity {
  int id;
  String name;

  PatternsEntity({
    required this.id,
    required this.name,
  });
}
