part of '_datasources.dart';

abstract class SemesterRemoteDataSource {
  String gpa = 0.toStringAsFixed(2);

  Future<Parsed<List<SemesterModel>>> getSemesters();

  Future<Parsed<List<SemesterModel>>> postSemester(List<String> givenSemesters);

  Future<Parsed<void>> deleteSemester(QuerySemester q);

  Future<Parsed<List<SemesterModel>>> getAutoFillSemester();

  Future<Parsed<SemesterModel>> postAutoFillSemester(
    Map<String, dynamic> model,
  );
}

class SemesterRemoteDataSourceImpl extends SemesterRemoteDataSource {
  final _dummyData = DummyData.getDummyData;

  @override
  Future<Parsed<List<SemesterModel>>> getSemesters() async {
    final list = <SemesterModel>[];
    final url = EndpointsRevamp.semesters;
    final resp = await getIt(url);
    if (resp.dataBodyIterable['all_semester_gpa'] != null) {
      for (final data in resp.dataBodyIterable['all_semester_gpa']) {
        list.add(SemesterModel.fromJson(data));
      }
      super.gpa = resp.userGPA.toStringAsFixed(2);
    }
    return resp.parse(list);

    // final resp = getItAll();
    // for (final data in resp['all_semester_gpa']) {
    //   list.add(SemesterModel.fromJson(data));
    // }
    // return Parsed.fromJson(
    //   resp,
    //   200,
    //   list,
    // );
  }

  @override
  Future<Parsed<List<SemesterModel>>> postSemester(
    List<String> givenSemesters,
  ) async {
    final url = EndpointsRevamp.semesters;
    final resp = await postIt(
      url,
      model: <String, List<String>>{
        'given_semesters': givenSemesters,
      },
    );
    final dataResponse = List.generate(
      resp.dataBodyIterable.length,
      (index) => SemesterModel.fromJson(
        resp.dataBodyIterable[index],
      ),
    );
    return resp.parse(dataResponse);

    // final resp = postIt(model);
    // return Parsed.fromJson(
    //   resp,
    //   200,
    //   SemesterModel.fromJson(resp),
    // );
  }

  @override
  Future<Parsed<void>> deleteSemester(QuerySemester q) async {
    final url = '${EndpointsRevamp.semesters}/${q.givenSemester}';
    final resp = await deleteIt(url);
    return resp.parse(null);
    // final resp = deleteIt(q);
    // return Parsed.fromJson(
    //   resp,
    //   204,
    //   null,
    // );
  }

  //////////////////////////////////////
  /// (Development only) "API" Calls ///
  //////////////////////////////////////

  // Map<String, dynamic> getItAll() {
  //   return <String, dynamic>{
  //     'all_semester_gpa': _dummyData['data']['all_semester_gpa']
  //   };
  // }

  // Map<String, dynamic> getItSingle(String givenSemester) {
  //   final semester = _dummyData['data']['all_semester_gpa'].firstWhere(
  //     (semester) => semester['given_semester'] == givenSemester,
  //     orElse: () => null,
  //   );
  //   return semester ?? <String, dynamic>{};
  // }

  // Map<String, dynamic> postIt(Map<String, dynamic> model) {
  //   _dummyData['data']['all_semester_gpa'].add(model);

  //   calculateNewGPA();

  //   return <String, dynamic>{
  //     'data': model,
  //     'status_code': 201,
  //   };
  // }

  // Map<String, dynamic> putIt(Map<String, dynamic> model) {
  //   _dummyData['data']['all_semester_gpa'].forEach((semester) {
  //     if (semester['given_semester'] == model['given_semester']) {
  //       semester = model; // Change the content of that item
  //     }
  //   });

  //   calculateNewGPA();

  //   return <String, dynamic>{
  //     'data': model,
  //     'status_code': 200,
  //   };
  // }

  // Map<String, dynamic> deleteIt(QuerySemester q) {
  //   print(q.givenSemester);
  //   _dummyData['data']['all_semester_gpa'].removeWhere(
  //     (semester) => semester['given_semester'] == q.givenSemester,
  //   );

  //   calculateNewGPA();

  //   return <String, dynamic>{
  //     'data': 'Deleted successfully!',
  //     'status_code': 204,
  //   };
  // }

  /// Calculate total SKS after adding or deleting a semester.
  void calculateSKS() {
    var sks = 0;
    for (final semester in _dummyData['data']['all_semester_gpa']) {
      sks += semester['total_sks'] as int;
    }

    _dummyData['data']['cumulative_gpa']['total_sks'] = sks;
  }

  /// Calculate cumulative GPA after adding or deleting a semester.
  void calculateTotalGPA() {
    var totalGPA = 0.0;
    for (final semester in _dummyData['data']['all_semester_gpa']) {
      totalGPA +=
          (semester['semester_gpa'] as double) * (semester['total_sks'] as int);
    }

    _dummyData['data']['cumulative_gpa']['total_gpa'] = totalGPA;
  }

  /// Calculate new cumulative GPA.
  void calculateNewGPA() {
    calculateSKS();
    calculateTotalGPA();

    _dummyData['data']['cumulative_gpa']['cumulative_gpa'] = _dummyData['data']
            ['cumulative_gpa']['total_gpa'] /
        _dummyData['data']['cumulative_gpa']['total_sks'];
  }

  @override
  Future<Parsed<List<SemesterModel>>> getAutoFillSemester() async {
    final list = <SemesterModel>[];
    final url = EndpointsRevamp.semesters;
    final resp = await getIt(url);
    final datasNeeded = resp.bodyAsMap['data']['courses'];
    for (var index = 0; index < datasNeeded.length ; index++) {
      final data = datasNeeded[index];
      if (data.isNotEmpty) {
        final givenSemester = index.toString();
        final courseList = <String>[];
        for (final course in data) {
          courseList.add(course['name']);
        }
        list.add(SemesterModel.forAutofill(givenSemester, courseList));
      }
    }
    return Parsed.fromJson(
      resp.bodyMap,
      200,
      list,
    );
  }

  @override
  Future<Parsed<SemesterModel>> postAutoFillSemester(
    Map<String, dynamic> model,
  ) async {
    // final url = EndpointsV1.components;
    // final resp = await postIt(url, model: model);
    // return resp.parse(SemesterModel.fromJson(resp.dataBodyAsMap));
    final url = EndpointsRevamp.autofill;
    final resp = await postIt(url, model: model);
    return Parsed.fromJson(
      resp.bodyAsMap,
      200,
      SemesterModel.fromJson(resp.data as Map<String, dynamic>),
    );
  }
}
