import "package:white_tiger_shop/product/model/entity/sort_option.dart";

class SortOptions {
  List<SortOption> options = [
    noSort,
    byLowerPrice,
    byHigherPrice,
    byLessPopular,
    byMorePopular,
    byOlder,
    byNewer,
  ];
}

final noSort = SortOption('Нет', null);
final byLowerPrice = SortOption('Сначала дешевле', 1);
final byHigherPrice = SortOption('Сначала дороже', 2);
final byLessPopular = SortOption('Сначала не популярнее', 3);
final byMorePopular = SortOption('Сначала популярнее', 4);
final byOlder = SortOption('Сначала старые', 5);
final byNewer = SortOption('Сначала новые', 6);
