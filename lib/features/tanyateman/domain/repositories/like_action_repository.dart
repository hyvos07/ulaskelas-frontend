part of '_repositories.dart';

abstract class LikeActionRepository {
  Future<Decide<Failure, Parsed<void>>> likeQuestion(int id);
  Future<Decide<Failure, Parsed<void>>> likeAnswer(int id);
}
