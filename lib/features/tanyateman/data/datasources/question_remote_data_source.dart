part of '_datasources.dart';

abstract class QuestionRemoteDataSource {
  Future<Parsed<List<QuestionModel>>> getAllQuestions(QueryQuestion query);
  Future<Parsed<Map<String,dynamic>>> postQuestion(Map<String,dynamic> model);
  Future<Parsed<void>> deleteQuestion(int id);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final _dummyData = DummyData.dummyData;

  @override
  Future<Parsed<List<QuestionModel>>> getAllQuestions(
    QueryQuestion query,
  ) async {
    final list = <QuestionModel>[];
    final resp = {
      'data': _dummyData['data'].sublist(
        (query.page! - 1) * query.limit,
        query.page! * query.limit > 25 ? 25 : query.page! * query.limit,
      ),
    };
    for (var i = 0; i < resp['data'].length; i++) {
      list.add(QuestionModel.fromJson(resp['data'][i]));
    }
    return Parsed.fromJson(
      resp,
      200,
      list,
    );
  }

  @override
  Future<Parsed<Map<String,dynamic>>> postQuestion(
    Map<String,dynamic> model) async {
    final url = EndpointsRevamp.tanyaTeman;
    final resp = await postIt(url, model: model);
    return Parsed.fromJson(
      resp.bodyAsMap,
      200, 
      resp.data
    );
  }

  @override
  Future<Parsed<void>> deleteQuestion(int id) async {
    throw UnimplementedError();
  }
}
