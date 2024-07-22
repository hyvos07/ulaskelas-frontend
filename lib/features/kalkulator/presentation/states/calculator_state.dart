part of '_states.dart';

class CalculatorState {
  CalculatorState() {
    final remoteDataSource = CalculatorRemoteDataSourceImpl();
    _repo = CalculatorRepositoryImpl(remoteDataSource);
  }

  late CalculatorRepository _repo;
  List<CalculatorModel>? _calculators;

  List<CalculatorModel> get calculators => _calculators ?? [];

  bool hasReachedMax = false;
  int page = 1;

  String? cacheKey = 'calculator-state';

  bool getCondition() {
    print('data ${_calculators?.isNotEmpty}');
    return _calculators?.isNotEmpty ?? false;
  }

  Future<void> retrieveData() async {
    final resp = await _repo.getAllCalculator();
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _calculators = result.data;
      print(_calculators);
    });
    calculatorRM.notify();
  }

  Future<void> postCalculator(String courseCode) async {
    final resp = await _repo.postCalculator(courseCode);
    await resp.fold((failure) {
      ErrorMessenger('Kalkulator dengan Mata Kuliah tersebut sudah ada')
          .show(ctx!);
    }, (result) async {
      SuccessMessenger('Kalkulator berhasil dibuat').show(ctx!);
      final calcResp = await _repo.getAllCalculator();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _calculators = result.data;
        print(_calculators);
      });
    });
    calculatorRM.notify();
  }

  Future<void> postMultipleCalculator(
    List<CourseModel> selectedCourse,
  ) async {
    final failedResponse = <String>[];
    // Sementara hit API satu per satu dulu yah hehe
    for (final course in selectedCourse) {
      final resp = await _repo.postCalculator(course.code!);
      await resp.fold((failure) {
        // ErrorMessenger('Kalkulator dengan Mata Kuliah tersebut sudah ada')
        //     .show(ctx!);
        failedResponse.add(course.name!);
      }, (result) async {
        if (kDebugMode) {
          print('Successfully created calculator for ${course.name}');
        }
      });
      await Future.delayed(const Duration(milliseconds: 10));
    }

    if (failedResponse.isEmpty) {
      SuccessMessenger('Semua kalkulator berhasil dibuat').show(ctx!);
      final calcResp = await _repo.getAllCalculator();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _calculators = result.data;
        print(_calculators);
      });
    } else if (failedResponse.length < selectedCourse.length) {
      final failedMessage = _joinAll(failedResponse);
      ErrorMessenger('Kalkulator $failedMessage sudah pernah dibuat')
          .show(ctx!);
    } else {
      ErrorMessenger(
        'Semua kalkulator yang dipilih sudah pernah dibuat sebelumnya',
      ).show(ctx!);
    }

    await searchCourseRM.setState((s) => s.clearSelectedCourses());

    calculatorRM.notify();
  }

  Future<void> deleteCalculator({
    required QueryCalculator query,
    required String courseName,
    required double totalScore,
  }) async {
    final resp = await _repo.deleteCalculator(query);
    MixpanelService.track(
      'calculator_delete_course_component',
      params: {
        'course_id': courseName,
        'final_letter_grade': totalScore.toString(),
        'final_grade': getFinalGrade(totalScore),
      },
    );
    await resp.fold((failure) {
      ErrorMessenger('Kalkulator gagal dihapus').show(ctx!);
    }, (result) async {
      SuccessMessenger('Kalkulator berhasil dihapus').show(ctx!);
      final calcResp = await _repo.getAllCalculator();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _calculators = result.data;
        print(_calculators);
      });
    });
    calculatorRM.notify();
  }

  String _joinAll(List<String> list) {
    final buffer = StringBuffer();
    for (var i = 0; i < list.length; i++) {
      buffer.write(list[i]);
      if (i < list.length - 1) {
        buffer.write(', ');
      } else {
        buffer.write(', dan ');
      }
    }
    return buffer.toString();
  }
}
