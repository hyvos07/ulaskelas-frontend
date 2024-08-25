part of '_datasources.dart';

abstract class LikeActionRemoteDataSource {
  Future<Parsed<void>> likeQuestion(
    int id,
  );
  Future<Parsed<void>> likeAnswer(
    int id,
  );
}

class LikeActionRemoteDataSourceImpl implements LikeActionRemoteDataSource {
  @override
  Future<Parsed<void>> likeQuestion(int id) async {
    final url = '${EndpointsRevamp.likePost}&id=$id';
    final resp = await putIt(url);
    return resp.parse(null);
  }

  @override
  Future<Parsed<void>> likeAnswer(int id) async {
    final url = '${EndpointsRevamp.likeReply}&id=$id';
    final resp = await putIt(url);
    return resp.parse(null);
  }
}
