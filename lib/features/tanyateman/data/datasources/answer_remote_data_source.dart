part of '_datasources.dart';

abstract class AnswerRemoteDataSource {
  Future<Parsed<List<AnswerModel>>> getAllAnswers(QueryAnswer query);
  Future<Parsed<Map<String, dynamic>>> postAnswer(Map<String, dynamic> model);
}

class AnswerRemoteDataSourceImpl implements AnswerRemoteDataSource {
  @override
  Future<Parsed<List<AnswerModel>>> getAllAnswers(
    QueryAnswer query,
  ) async {
    final list = <AnswerModel>[];
    final url = '${EndpointsRevamp.jawabTeman}?${query.generateQueryString()}';
    final resp = await getIt(url);

    if (resp.data['total_page'] < query.page) {
      if (kDebugMode) {
        print('hasReachedMax');
      }
      return resp.parse([]); // return empty list; trigger hasReachedMax
    }

    for (var i = 0; i < resp.dataBodyAsMap['answers'].length; i++) {
      list.add(AnswerModel.fromJson(resp.dataBodyAsMap['answers'][i]));
    }

    return resp.parse(list);
  }


  @override
  Future<Parsed<Map<String, dynamic>>> postAnswer(
      Map<String, dynamic> model) async {
    final url = EndpointsRevamp.jawabTeman;
    final resp = await postWithFileInIt(url, model: model);
    return Parsed.fromJson(resp.bodyAsMap, 200, resp.data);
  }

}
