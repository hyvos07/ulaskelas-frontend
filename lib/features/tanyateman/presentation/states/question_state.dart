part of '_states.dart';

class QuestionState {
  QuestionState() {
    final remoteDataSource = QuestionRemoteDataSourceImpl();
    _repo = QuestionRepositoryImpl(remoteDataSource);
    final likeRemoteDataSource = LikeActionRemoteDataSourceImpl();
    _likeRepo = LikeActionRepositoryImpl(likeRemoteDataSource);
  }

  late QuestionRepository _repo;
  late LikeActionRepository _likeRepo;

  int page = 1;
  bool hasReachedMax = false;
  String allQuestionsFilter = 'semua';
  CourseModel? allQuestionsCourseFilter;
  String historyQuestionsFilter = 'semua';
  CourseModel? historyQuestionsCourseFilter;

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
      retrieveAllQuestions(queryAll),
      retrieveHistoryQuestions(queryHistory),
    ]);
  }

  ////////////////////
  /// All Question ///
  ////////////////////

  Future<void> retrieveAllQuestions(QueryQuestion q) async {
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

  Future<void> retrieveMoreAllQuestions(QueryQuestion q) async {
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

  Future<void> retrieveMoreHistoryQuestions(QueryQuestion q) async {
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

  Future<bool> deleteQuestion(int id) async {
    var isSucces = false;
    final resp = await _repo.deleteQuestion(id);
    resp.fold((failure) {
      ErrorMessenger(
        'Gagal menghapus pertanyaan!',
      ).show(ctx!);
    }, (result) {
      SuccessMessenger(
        'Berhasil menghapus pertanyaan!',
      ).show(ctx!);
      isSucces = true;
    });

    questionsRM.notify();
    return isSucces;
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
      questionsRM.notify();
    });
  }

  Future<void> updateLikeAndComment(
    int id, Map<String,dynamic> data,) async{
      _allQuestions!.map(
        (e) {
          if (e.id == id) {
            e..likeCount = data['like_count']
            ..replyCount = data['reply_count'];
          }
          return e;
        }
      ).toList();

      questionsRM.notify();
  }
}
