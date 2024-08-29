part of '_repositories.dart';

abstract class AnswerRepository {
  Future<Decide<Failure, Parsed<Map<String,dynamic>>>> getAllAnswers(
    QueryAnswer query,
  );
  Future<Decide<Failure, Parsed<Map<String,dynamic>>>> postAnswer(
    Map<String,dynamic> model,
  );
}
