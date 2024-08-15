part of '_states.dart';

class QuestionState {
  QuestionState() {
    final remoteDataSource = QuestionRemoteDataSourceImpl();
    _repo = QuestionRepositoryImpl(remoteDataSource);
  }

  late QuestionRepository _repo;

  int page = 1;
  bool hasReachedMax = false;
  String allQuestionsFilter = 'semua';
  String historyQuestionsFilter = 'semua';
  List<QuestionModel>? _questions;

  List<QuestionModel> get questions => _questions ?? [];

  /// Used for retrieve data on both all questions and history questions
  Future<void> retrieveData({
    required QueryQuestion queryAll,
    required QueryQuestion queryHistory,
  }) async {
    await Future.wait([
      retrieveAllQuestion(queryAll),
      // retrieveHistoryQuestion(q),
    ]);
  }

  Future<void> retrieveAllQuestion(QueryQuestion q) async {
    page = 1;
    q.page = page;
    print('retrieveAllQuestion, with query page: ${q.page}');
    final resp = await _repo.getAllQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _questions = result.data;
      if (kDebugMode) {
        print(_questions);
      }
    });

    questionsRM.notify();
  }

  Future<void> retrieveMoreQuestion(QueryQuestion q) async {
    ++page;
    q.page = page;
    print('retrieveMoreData, with query page: ${q.page}');
    final resp = await _repo.getAllQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      _questions?.addAll(result.data);
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      if (kDebugMode) {
        print(_questions);
      }
    });

    questionsRM.notify();
  }
}
