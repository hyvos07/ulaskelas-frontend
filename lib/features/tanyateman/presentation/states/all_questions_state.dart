part of '_states.dart';

class AllQuestionState
    implements FutureState<AllQuestionState, QuerySearchCourse> {
  AllQuestionState() {}

  @override
  String? cacheKey = CacheKey.newsState;

  @override
  bool getCondition() {
    return true;
  }

  @override
  Future<void> retrieveData(QuerySearchCourse query) async {
    throw UnimplementedError();
  }
}
