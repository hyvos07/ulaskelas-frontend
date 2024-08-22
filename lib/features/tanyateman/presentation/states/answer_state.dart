part of '_states.dart';

class AnswerState {
  AnswerState() {
    final remoteDataSource = AnswerRemoteDataSourceImpl();
    _repo = AnswerRepositoryImpl(remoteDataSource);
  }

  late AnswerRepository _repo;

  int page = 1;
  bool hasReachedMax = false;

  List<AnswerModel>? _allAnswer;

  List<AnswerModel> get allAnswer => _allAnswer ?? [];

  Future<void> retrieveAllAnswer(QueryAnswer q) async {
    page = 1;
    q.page = page;
    print('retrieveAnswer, with query page: ${q.page}');
    final resp = await _repo.getAllAnswers(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _allAnswer = result.data;
      if (kDebugMode) {
        print(_allAnswer);
      }
    });

    answersRM.notify();
  }

  Future<void> retrieveMoreAllAnswer(QueryAnswer q) async {
    ++page;
    q.page = page;
    print('retrieveMoreData, with query page: ${q.page}');
    final resp = await _repo.getAllAnswers(q);
    resp.fold((failure) => throw failure, (result) {
      _allAnswer?.addAll(result.data);
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      if (kDebugMode) {
        print(_allAnswer);
      }
    });

    answersRM.notify();
  }
}
