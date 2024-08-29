part of '_states.dart';

class AnswerState {
  AnswerState() {
    final remoteDataSource = AnswerRemoteDataSourceImpl();
    _repo = AnswerRepositoryImpl(remoteDataSource);
    final likeRemoteDataSource = LikeActionRemoteDataSourceImpl();
    _likeRepo = LikeActionRepositoryImpl(likeRemoteDataSource);
  }

  late AnswerRepository _repo;
  late LikeActionRepository _likeRepo;

  int page = 1;
  bool hasReachedMax = false;

  List<AnswerModel>? _allAnswer;

  List<AnswerModel> get allAnswer => _allAnswer ?? [];

  Future<Map<String,dynamic>> retrieveAllAnswer(QueryAnswer q) async {
    final data = <String,dynamic>{};
    page = 1;
    q.page = page;
    print('retrieveAnswer, with query page: ${q.page}');
    final resp = await _repo.getAllAnswers(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _allAnswer = result.data['answers'];
      data['like_count'] = result.data['like_count'];
      data['reply_count'] = result.data['reply_count'];
      if (kDebugMode) {
        print(_allAnswer);
        print(data);
      }
    });

    answersRM.notify();
    return data;
  }

  Future<void> retrieveMoreAllAnswer(QueryAnswer q) async {
    ++page;
    q.page = page;
    print('retrieveMoreData, with query page: ${q.generateQueryString()}');
    final resp = await _repo.getAllAnswers(q);
    resp.fold((failure) => throw failure, (result) {
      _allAnswer?.addAll(result.data['answers']);
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      if (kDebugMode) {
        print(_allAnswer);
      }
    });

    answersRM.notify();
  }

  Future<void> likeAnswer(AnswerModel model) async {
    final resp = await _likeRepo.likeAnswer(model.id);
    resp.fold((failure) {
      if (kDebugMode) {
        Logger().e(failure.message);
      }
      ErrorMessenger(
        'Gagal menyukai jawaban!',
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
      answersRM.notify();
    });
  }
}
