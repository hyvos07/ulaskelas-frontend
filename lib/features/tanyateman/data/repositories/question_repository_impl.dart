part of '_repositories.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  QuestionRepositoryImpl(
    this._remoteDataSource,
  );

  final QuestionRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<List<QuestionModel>>>>
      getAllQuestions(QueryQuestion query) {
    return apiCall(_remoteDataSource.getAllQuestions(query));
  }

  @override
  Future<Decide<Failure, Parsed<QuestionModel>>>
      postQuestion(QuestionModel model) {
    return apiCall(_remoteDataSource.postQuestion(model));
  }

  @override
  Future<Decide<Failure, Parsed<void>>>
      deleteQuestion(int questionId) {
    return apiCall(_remoteDataSource.deleteQuestion(questionId));
  }
}