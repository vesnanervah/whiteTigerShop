import "package:white_tiger_shop/product/model/entity/sort_option.dart";

class SortOptions {
  // TODO: вынести в статическую переменную SortOption.values. Тогда не придется объявлять переменные этого класса
  List<SortOption> options = [
    SortOption('Нет', null),
    SortOption('Сначала дешевле', 1),
    SortOption('Сначала дороже', 2),
    SortOption('Сначала не популярнее', 3),
    SortOption('Сначала популярнее', 4),
    SortOption('Сначала старые', 5),
    SortOption('Сначала новые', 6),
  ];
}
