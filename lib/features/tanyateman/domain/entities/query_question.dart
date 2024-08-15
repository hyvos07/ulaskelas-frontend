import 'package:ulaskelas/core/_core.dart';

class QueryQuestion {
  QueryQuestion({
    this.page,
    this.limit = Constants.limitPagination,
    this.byUser = false,
    this.isHistory,
    this.isMostPopular,
    this.isVerified,
    this.isWaitToVerify
  });

  int? page;
  bool? byUser;
  int? limit;
  bool? isHistory;
  bool? isMostPopular;
  bool? isVerified;
  bool? isWaitToVerify;

  @override
  String toString() {
    final data = <String, String>{};
    data['page'] = page.toString();
    data['limit'] = limit.toString();
    data['by_user'] = byUser.toString();
    data['is_history'] = isHistory.toString();
    data['is_paling_banyak_disukai'] = isMostPopular.toString();
    data['terverifikasi'] = isVerified.toString();
    data['menunggu_verifikasi'] = isWaitToVerify.toString();
    return Uri(queryParameters: data).query;
  }

  String generateQueryString() {
    final data = <String, String>{};

    if (page != null) data['page'] = page.toString();
    if (limit != null) data['limit'] = limit.toString();
    if (byUser != null) data['by_user'] = byUser.toString();
    if (isHistory != null) data['is_history'] = isHistory.toString();
    if (isMostPopular != null) data['is_paling_banyak_disukai'] = isMostPopular.toString();
    if (isVerified != null) data['terverifikasi'] = isVerified.toString();
    if (isWaitToVerify != null) data['menunggu_verifikasi'] = isWaitToVerify.toString();

    return Uri(queryParameters: data).query;
  }
}
