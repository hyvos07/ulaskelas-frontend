import 'package:ulaskelas/core/_core.dart';

class QueryAnswer{
  QueryAnswer({
    this.page,
    this.limit = Constants.limitPagination,
    this.byUser = false,
  });

  int? page;
  bool? byUser;
  int? limit;

  @override
  String toString() {
    final data = <String, String>{};
    data['page'] = page.toString();
    data['limit'] = limit.toString();
    data['by_user'] = byUser.toString();
    return Uri(queryParameters: data).query;
  }

  String generateQueryString() {
    final data = <String, String>{};

    if (page != null) data['page'] = page.toString();
    if (limit != null) data['limit'] = limit.toString();
    if (byUser != null) data['by_user'] = byUser.toString();

    return Uri(queryParameters: data).query;
  }
}