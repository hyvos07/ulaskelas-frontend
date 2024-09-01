part of '_states.dart';

class SearchQuestionState {
  SearchQuestionState() {
    final remoteDataSource = QuestionRemoteDataSourceImpl();
    _repo = QuestionRepositoryImpl(remoteDataSource);
    final likeRemoteDataSource = LikeActionRemoteDataSourceImpl();
    _likeRepo = LikeActionRepositoryImpl(likeRemoteDataSource);

    controller = TextEditingController();
  }

  late TextEditingController controller;
  late QuestionRepository _repo;
  late LikeActionRepository _likeRepo;

  int page = 1;
  bool hasReachedMax = false;
  String searchQuestionFilter = 'semua';
  SearchData? searchData;
  String? _lastQuery;
  ListQueue<String>? _history;
  List<QuestionModel>? _searchedQuestions;

  List<QuestionModel> get searchedQuestions => _searchedQuestions ?? [];
  ListQueue<String> get history => _history ?? ListQueue();
  String get lastQuery => _lastQuery ?? '';
  set lastQuery(String val) => _lastQuery = val;

  /// Every submitted query will added to history
  void addToHistory(String query) {
    if (query.isEmpty) return;
    _history ??= ListQueue<String>();
    if (!history.contains(query)) {
      _history?.addFirst(query);
    }
    if (history.length == 11) {
      _history?.removeLast();
    }
  }

  /// Clear search history from local state and local storage.
  void clearHistory() {
    _history?.clear();
  }

  ///////////////////////
  /// Search Question ///
  ///////////////////////

  Future<void> retrieveSearchedQuestion(QueryQuestion q) async {
    page = 1;
    q.page = page;
    final resp = await _repo.getSearchQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _searchedQuestions = result.data;
      if (kDebugMode) {
        print(_searchedQuestions);
      }
    });

    questionsRM.notify();
  }

  Future<void> retrieveMoreSearchedQuestion(QueryQuestion q) async {
    ++page;
    q.page = page;
    final resp = await _repo.getSearchQuestions(q);
    resp.fold((failure) => throw failure, (result) {
      _searchedQuestions?.addAll(result.data);
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      if (kDebugMode) {
        print(_searchedQuestions);
      }
    });

    questionsRM.notify();
  }

  Future<void> likeQuestion(QuestionModel model) async {
    final resp = await _likeRepo.likeQuestion(model.id);
    resp.fold((failure) {
      if (kDebugMode) {
        Logger().e(failure.message);
      }
      ErrorMessenger(
        'Gagal menyukai pertanyaan!',
      ).show(ctx!);
    }, (result) {
      // Change the like status locally
      if (model.likedByUser) {
        model.likedByUser = false;
        model.likeCount--;
      } else {
        model.likedByUser = true;
        model.likeCount++;
      }
      searchQuestionRM.notify();
    });
  }
}

class SearchData {
  SearchData({
    this.text,
    this.course,
  });

  final String? text;
  final CourseModel? course;
}
