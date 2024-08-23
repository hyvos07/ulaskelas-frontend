part of '_repositories.dart';

abstract class QuestionRepository {
  Future<Decide<Failure, Parsed<List<QuestionModel>>>> getAllQuestions(
    QueryQuestion query,
  );
  Future<Decide<Failure, Parsed<List<QuestionModel>>>> getHistoryQuestions(
    QueryQuestion query,
  );
  Future<Decide<Failure, Parsed<List<QuestionModel>>>> getSearchQuestions(
    QueryQuestion query,
  );
  Future<Decide<Failure, Parsed<Map<String,dynamic>>>> postQuestion(
    Map<String,dynamic> model,
  );
  Future<Decide<Failure, Parsed<void>>> deleteQuestion(int questionId);
}
