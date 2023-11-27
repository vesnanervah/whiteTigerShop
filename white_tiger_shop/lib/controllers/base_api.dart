import 'package:white_tiger_shop/types/types.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final key =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  final adress = 'hostest.whitetigersoft.ru/api';
  makeApiCall(String apiPath, ApiArgs? queryArgs) {
    String? queryString;
    if (queryArgs != null) {
      final queryKeys = queryArgs.keys.toList();
      final queryParams = queryKeys.reduce((value, element) =>
          queryKeys.indexOf(element) == queryKeys.length - 1
              ? '$value$element=${queryArgs[element]}'
              : '$value&$element=${queryArgs[element]}');
      queryString =
          queryParams.isNotEmpty ? '$queryParams&appKey=$key' : 'appKey=$key';
    }

    final uri =
        Uri(scheme: 'http', host: adress, path: apiPath, query: queryString);
    return http.get(uri);
  }
}
