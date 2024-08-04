part of '_repositories.dart';

abstract class QuestionRepository {
  Future<Decide<Failure, Parsed<List<QuestionModel>>>> getAllQuestions(
    QueryQuestion query,
  );
  Future<Decide<Failure, Parsed<QuestionModel>>> postQuestion(
    QuestionModel model,
  );
  Future<Decide<Failure, Parsed<void>>> deleteQuestion(int questionId);
}
