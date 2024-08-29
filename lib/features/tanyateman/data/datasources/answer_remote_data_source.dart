part of '_datasources.dart';

abstract class AnswerRemoteDataSource {
  Future<Parsed<Map<String,dynamic>>> getAllAnswers(QueryAnswer query);
  Future<Parsed<Map<String, dynamic>>> postAnswer(Map<String, dynamic> model);
}

class AnswerRemoteDataSourceImpl implements AnswerRemoteDataSource {
  @override
  Future<Parsed<Map<String,dynamic>>> getAllAnswers(
    QueryAnswer query,
  ) async {
    final data = <String,dynamic>{};

    final list = <AnswerModel>[];
    final url = '${EndpointsRevamp.jawabTeman}?${query.generateQueryString()}';
    final resp = await getIt(url);

    data['like_count'] = resp.dataBodyAsMap['like_count'];
    data['reply_count'] = resp.dataBodyAsMap['reply_count'];

    if (resp.data['total_page'] < query.page) {
      if (kDebugMode) {
        print('hasReachedMax');
      }
      data['answers'] = [];
      return resp.parse(data); // return empty list; trigger hasReachedMax
    }

    for (var i = 0; i < resp.dataBodyAsMap['answers'].length; i++) {
      list.add(AnswerModel.fromJson(resp.dataBodyAsMap['answers'][i]));
    }

    data['answers'] = list;

    return resp.parse(data);
  }


  @override
  Future<Parsed<Map<String, dynamic>>> postAnswer(
      Map<String, dynamic> model) async {
    final url = EndpointsRevamp.jawabTeman;
    final resp = await postWithFileInIt(url, model: model);
    return Parsed.fromJson(resp.bodyAsMap, 200, resp.data);
  }

}
