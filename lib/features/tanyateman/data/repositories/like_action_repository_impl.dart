part of '_repositories.dart';

class LikeActionRepositoryImpl extends LikeActionRepository{
  LikeActionRepositoryImpl(
    this._remoteDataSource,
  );

  final LikeActionRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<void>>> likeQuestion(int id) {
    return apiCall(_remoteDataSource.likeQuestion(id));
  }

  @override
  Future<Decide<Failure, Parsed<void>>> likeAnswer(int id) {
    return apiCall(_remoteDataSource.likeAnswer(id));
  }
}
