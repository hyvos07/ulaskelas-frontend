part of '_repositories.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  AnswerRepositoryImpl(
    this._remoteDataSource,
  );

  final AnswerRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<Map<String,dynamic>>>>
      getAllAnswers(QueryAnswer query) {
    return apiCall(_remoteDataSource.getAllAnswers(query));
  }

  @override
  Future<Decide<Failure, Parsed<Map<String,dynamic>>>>
      postAnswer(Map<String,dynamic> model) {
    return apiCall(_remoteDataSource.postAnswer(model));
  }
}
