part of '_datasources.dart';

abstract class QuestionRemoteDataSource {
  Future<Parsed<List<QuestionModel>>> getAllQuestions(QueryQuestion query);
  Future<Parsed<Map<String, dynamic>>> postQuestion(Map<String, dynamic> model);
  Future<Parsed<void>> deleteQuestion(int id);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  @override
  Future<Parsed<List<QuestionModel>>> getAllQuestions(
    QueryQuestion query,
  ) async {
    final list = <QuestionModel>[];
    final url = '${EndpointsRevamp.tanyaTeman}?${query.generateQueryString()}';
    final resp = await getIt(url);

    if (resp.data['total_page'] < query.page) {
      if (kDebugMode) {
        print('hasReachedMax');
      }
      return resp.parse([]); // return empty list; trigger hasReachedMax
    }

    for (var i = 0; i < resp.dataBodyAsMap['questions'].length; i++) {
      list.add(QuestionModel.fromJson(resp.dataBodyAsMap['questions'][i]));
    }

    return resp.parse(list);

    // final resp = {
    //   'data': _dummyData['data'].sublist(
    //     (query.page! - 1) * query.limit,
    //     query.page! * query.limit > 25 ? 25 : query.page! * query.limit,
    //   ),
    // };
    // for (var i = 0; i < resp['data'].length; i++) {
    //   list.add(QuestionModel.fromJson(resp['data'][i]));
    // }
    // return Parsed.fromJson(
    //   resp,
    //   200,
    //   list,
    // );
  }

  @override
  Future<Parsed<Map<String, dynamic>>> postQuestion(
      Map<String, dynamic> model) async {
    final url = EndpointsRevamp.tanyaTeman;
    final resp = await postWithFileInIt(url, model: model);
    return Parsed.fromJson(resp.bodyAsMap, 200, resp.data);
  }

  @override
  Future<Parsed<void>> deleteQuestion(int id) async {
    throw UnimplementedError();
  }
}
