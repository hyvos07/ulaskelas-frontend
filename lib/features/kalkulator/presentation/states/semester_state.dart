part of '_states.dart';

class SemesterState {
  SemesterState() {
    final remoteDataSource = SemesterRemoteDataSourceImpl();
    _repo = SemesterRepositoryImpl(remoteDataSource);
  }

  late SemesterRepository _repo;
  List<SemesterModel>? _semesters;

  List<SemesterModel> get semesters => _semesters ?? [];
  String get gpa => _repo.gpa;

  bool hasReachedMax = false;
  int page = 1;

  String? cacheKey = 'semester-state';

  bool getCondition() {
    print('data ${_semesters?.isNotEmpty}');
    return _semesters?.isNotEmpty ?? false;
  }

  Future<void> retrieveData() async {
    final resp = await _repo.getAllSemester();
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _semesters = result.data;
      print(_semesters);
    });
    semesterRM.notify();
  }

  Future<void> postSemester(Map<String, dynamic> model) async {
    final resp = await _repo.postSemester(model);
    await resp.fold((failure) {
      ErrorMessenger('Data Semester tersebut sudah pernah dibuat')
          .show(ctx!);
    }, (result) async {
      SuccessMessenger('Data Semester berhasil dibuat').show(ctx!);
      final calcResp = await _repo.getAllSemester();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _semesters = result.data;
        print(_semesters);
      });
    });
    semesterRM.notify();
  }

  Future<void> deleteSemester({
    required QuerySemester query,
    // required String courseName,
    // required double totalScore,
  }) async {
    final resp = await _repo.deleteSemester(query);
    // MixpanelService.track(
    //   'semester_delete_course_component',
    //   params: {
    //     'course_id': courseName,
    //     'final_letter_grade': totalScore.toString(),
    //     'final_grade': getFinalGrade(totalScore),
    //   },
    // );
    await resp.fold((failure) {
      ErrorMessenger('Data Semester gagal dihapus').show(ctx!);
    }, (result) async {
      SuccessMessenger('Data Semester berhasil dihapus').show(ctx!);
      final calcResp = await _repo.getAllSemester();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _semesters = result.data;
        print(_semesters);
      });
    });
    semesterRM.notify();
  }
}
