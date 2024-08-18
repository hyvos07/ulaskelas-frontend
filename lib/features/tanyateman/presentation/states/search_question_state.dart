part of '_states.dart';

class SearchQuestionState {
  SearchQuestionState() {
    final remoteDataSource = QuestionRemoteDataSourceImpl();
    _repo = QuestionRepositoryImpl(remoteDataSource);
  }

  late QuestionRepository _repo;

  int page = 1;
  bool hasReachedMax = false;
  String searchQuestionFilter = 'semua';
  SearchData? searchData;

  List<QuestionModel>? _searchedQuestions;
  List<QuestionModel> get searchedQuestions => _searchedQuestions ?? [];

  ///////////////////////
  /// Search Question ///
  ///////////////////////

  Future<void> retrieveSearchedQuestion(QueryQuestion q) async {
    page = 1;
    q.page = page;
    final resp = await _repo.getHistoryQuestions(q);
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
    final resp = await _repo.getHistoryQuestions(q);
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
}

class SearchData {
  SearchData({
    this.text,
    this.course,
  });

  final String? text;
  final CourseModel? course;
}