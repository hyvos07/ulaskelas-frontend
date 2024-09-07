part of '_states.dart';

class SemesterState {
  SemesterState() {
    final remoteDataSource = SemesterRemoteDataSourceImpl();
    _repo = SemesterRepositoryImpl(remoteDataSource);
  }

  late SemesterRepository _repo;
  List<SemesterModel>? _semesters;
  List<SemesterModel>? _autoFillSemesters;

  List<SemesterModel> get semesters => _semesters ?? [];
  List<SemesterModel> get autoFillSemesters => _autoFillSemesters ?? [];
  List<SemesterModel> get availableSemestersToFill =>
      (_semesters?.isEmpty ?? true)
          ? (_autoFillSemesters ?? [])
          : (_autoFillSemesters ?? []).where(
              (autoFillSemester) {
                return !semesters.any(
                  (semester) {
                    return semester.givenSemester ==
                        autoFillSemester.givenSemester;
                  },
                );
              },
            ).toList();

  String get cumulativeGPA => _repo.gpa;

  bool hasReachedMax = false;
  int page = 1;

  String? cacheKey = 'semester-state';

  bool getCondition() {
    print('data ${_semesters?.isNotEmpty}');
    return _semesters?.isNotEmpty ?? false;
  }

  Future<void> retrieveData() async {
    final resp = await _repo.getSemesters();
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _semesters = result.data;
      print(_semesters);
    });
    semesterRM.notify();

    // For Showcase Purpose (new user)
    if (Pref.getBool('doneAppTour') == false ||
        Pref.getBool('doneAppTour') == null) {
      if (semesterRM.state.semesters.isEmpty) {
        await showcaseEmptySemester();
      } else {
        await showcaseFilledSemester();
      }
    }
  }

  Future<void> postSemester(List<String> givenSemesters) async {
    final resp = await _repo.postSemester(givenSemesters);
    await resp.fold((failure) {
      ErrorMessenger('Data Semester tersebut sudah pernah dibuat').show(ctx!);
    }, (result) async {
      SuccessMessenger('Data Semester berhasil dibuat').show(ctx!);
      final calcResp = await _repo.getSemesters();
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
      final calcResp = await _repo.getSemesters();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _semesters = result.data;
        print(_semesters);
      });
    });
    semesterRM.notify();
  }

  Future<void> retrieveDataForAutoFillSemesters() async {
    final resp = await _repo.getAutoFillSemester();

    resp.fold((failure) => throw failure, (result) {
      _autoFillSemesters = result.data;
      print(_autoFillSemesters);
    });
    semesterRM.notify();
  }

  Future<void> postAutoFillSemester(Map<String, dynamic> model) async {
    final resp = await _repo.postAutoFillSemester(model);
    await resp.fold((failure) {
      ErrorMessenger('Data Semester gagal dibuat').show(ctx!);
    }, (result) async {
      SuccessMessenger('Data Semester berhasil dibuat').show(ctx!);
      final calcResp = await _repo.getSemesters();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _semesters = result.data;
        print(_semesters);
      });

      semesterRM.notify();

      // For Showcase Purpose (new user)
      if (Pref.getBool('doneAppTour') == false ||
          Pref.getBool('doneAppTour') == null) {
        final semester = _semesters!.where((e) => e.givenSemester == '1').first;
        await calculatorRM.state.retrieveData(semester.givenSemester!);
        final calculator = calculatorRM.state.calculators.first;
        await componentRM.state.addShowcaseComponent(calculator.id!);

        await showcaseFilledSemester();
      }
    });
  }
}
