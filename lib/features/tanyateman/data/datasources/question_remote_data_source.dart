part of '_datasources.dart';

abstract class QuestionRemoteDataSource {
  Future<Parsed<List<QuestionModel>>> getAllQuestions(QueryQuestion query);
  Future<Parsed<QuestionModel>> postQuestion(QuestionModel model);
  Future<Parsed<void>> deleteQuestion(int id);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final _dummyData = DummyData.dummyData;

  @override
  Future<Parsed<List<QuestionModel>>> getAllQuestions(
    QueryQuestion query,
  ) async {
    print('start ${(query.page! - 1) * query.limit}');
    print('end ${query.page! * query.limit}');
    final list = <QuestionModel>[];
    final resp = {
      'data': _dummyData['data'].sublist(
        (query.page! - 1) * query.limit,
        query.page! * query.limit > 25 ? 25 : query.page! * query.limit,
      ),
    };
    print(resp['data'].length);
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
  Future<Parsed<QuestionModel>> postQuestion(QuestionModel model) async {
    throw UnimplementedError();
  }

  @override
  Future<Parsed<void>> deleteQuestion(int id) async {
    throw UnimplementedError();
  }
}
