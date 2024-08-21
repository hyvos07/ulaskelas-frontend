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

  List<QuestionModel>? _allQuestions;
  List<QuestionModel>? _historyQuestions;

  List<QuestionModel> get allQuestions => _allQuestions ?? [];
  List<QuestionModel> get historyQuestions => _historyQuestions ?? [];

  /// Used for retrieve data on both all questions and history questions
  Future<void> retrieveData({
    required QueryQuestion queryAll,
    required QueryQuestion queryHistory,
  }) async {
    await Future.wait([
      retrieveAllQuestion(queryAll),
      retrieveHistoryQuestions(queryHistory),
    ]);
  }

  ////////////////////
  /// All Question ///
  ////////////////////

  Future<void> retrieveAllQuestion(QueryQuestion q) async {
    page = 1;
    q.page = page;
    print('retrieveAllQuestion, with query page: ${q.page}');
    final resp = await _repo.getAllQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _allQuestions = result.data;
      if (kDebugMode) {
        print(_allQuestions);
      }
    });

    questionsRM.notify();
  }

  Future<void> retrieveMoreAllQuestion(QueryQuestion q) async {
    ++page;
    q.page = page;
    print('retrieveMoreData, with query page: ${q.page}');
    final resp = await _repo.getAllQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      _allQuestions?.addAll(result.data);
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      if (kDebugMode) {
        print(_allQuestions);
      }
    });

    questionsRM.notify();
  }

  ////////////////////////
  /// History Question ///
  ////////////////////////

  Future<void> retrieveHistoryQuestions(QueryQuestion q) async {
    page = 1;
    q.page = page;
    final resp = await _repo.getHistoryQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _historyQuestions = result.data;
      if (kDebugMode) {
        print(_historyQuestions);
      }
    });

    questionsRM.notify();
  }

  Future<void> retrieveMoreHistoryQuestion(QueryQuestion q) async {
    ++page;
    q.page = page;
    final resp = await _repo.getHistoryQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      _historyQuestions?.addAll(result.data);
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      if (kDebugMode) {
        print(_historyQuestions);
      }
    });

    questionsRM.notify();
  }

  Future<void> deleteQuestion(int id) async {
    final resp = await _repo.deleteQuestion(id);
    resp.fold(
      (failure) {
        ErrorMessenger(
          'Gagal menghapus pertanyaan!').show(ctx!);}, 
      (result) {
        SuccessMessenger(
          'Berhasil menghapus pertanyaan!').show(ctx!);}
    );

    questionsRM.notify();
  }

}
