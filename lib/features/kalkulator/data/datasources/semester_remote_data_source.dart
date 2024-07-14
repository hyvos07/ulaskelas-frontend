part of '_datasources.dart';

abstract class SemesterRemoteDataSource {
  String? get gpa => null;

  Future<Parsed<List<SemesterModel>>> getAllSemester();

  Future<Parsed<SemesterModel>> getSemester(QuerySemester q);

  Future<Parsed<SemesterModel>> postSemester(Map<String, dynamic> model);

  Future<Parsed<SemesterModel>> editSemester(Map<String, dynamic> model);

  Future<Parsed<void>> deleteSemester(QuerySemester q);
}

class SemesterRemoteDataSourceImpl extends SemesterRemoteDataSource {
  final _dummyData = DummyData.getDummyData;

  @override
  String get gpa =>
      _dummyData['data']['cumulative_gpa']['cumulative_gpa'].toStringAsFixed(2);

  @override
  Future<Parsed<List<SemesterModel>>> getAllSemester() async {
    final list = <SemesterModel>[];
    // final url = EndpointsV1.components;
    // final resp = await getIt();
    // for (final data in resp.dataBodyIterable) {
    //   list.add(SemesterModel.fromJson(data));
    // }
    // return resp.parse(list);
    final resp = getItAll();
    for (final data in resp['all_semester_gpa']) {
      list.add(SemesterModel.fromJson(data));
    }
    return Parsed.fromJson(
      resp,
      200,
      list,
    );
  }

  @override
  Future<Parsed<SemesterModel>> getSemester(QuerySemester q) async {
    // final url = '${EndpointsV1.components}?$q';
    // final resp = await getIt(url);
    // return resp.parse(SemesterModel.fromJson(resp.dataBodyAsMap));
    final resp = getItSingle(q.givenSemester!);

    if (resp.isEmpty) {
      print('Error: ${resp['error']}');
      return Parsed.fromJson(
        resp,
        404,
        SemesterModel(), // Empty model
      );
    }

    return Parsed.fromJson(
      resp,
      200,
      SemesterModel.fromJson(resp),
    );
  }

  @override
  Future<Parsed<SemesterModel>> postSemester(
    Map<String, dynamic> model,
  ) async {
    // final url = EndpointsV1.components;
    // final resp = await postIt(url, model: model);
    // return resp.parse(SemesterModel.fromJson(resp.dataBodyAsMap));
    final resp = postIt(model);
    return Parsed.fromJson(
      resp,
      200,
      SemesterModel.fromJson(resp),
    );
  }

  @override
  Future<Parsed<SemesterModel>> editSemester(
    Map<String, dynamic> model,
  ) async {
    // final url = EndpointsV1.components;
    // final resp = await putIt(url, model: model);
    // return resp.parse(SemesterModel.fromJson(resp.dataBodyAsMap));
    final resp = putIt(model);
    return Parsed.fromJson(
      resp,
      200,
      SemesterModel.fromJson(resp),
    );
  }

  @override
  Future<Parsed<void>> deleteSemester(QuerySemester q) async {
    // final url = '${EndpointsV1.components}?$q';
    // final resp = await deleteIt(url);
    // return resp.parse(null);
    final resp = deleteIt(q);
    return Parsed.fromJson(
      resp,
      204,
      null,
    );
  }

  //////////////////////////////////////
  /// (Development only) "API" Calls ///
  //////////////////////////////////////

  Map<String, dynamic> getItAll() {
    return <String, dynamic>{
      'all_semester_gpa': _dummyData['data']['all_semester_gpa']
    };
  }

  Map<String, dynamic> getItSingle(String givenSemester) {
    final semester = _dummyData['data']['all_semester_gpa'].firstWhere(
      (semester) => semester['given_semester'] == givenSemester,
      orElse: () => null,
    );
    return semester ?? <String, dynamic>{};
  }

  Map<String, dynamic> postIt(Map<String, dynamic> model) {
    _dummyData['data']['all_semester_gpa'].add(model);

    calculateNewGPA();

    return <String, dynamic>{
      'data': model,
      'status_code': 201,
    };
  }

  Map<String, dynamic> putIt(Map<String, dynamic> model) {
    _dummyData['data']['all_semester_gpa'].forEach((semester) {
      if (semester['given_semester'] == model['given_semester']) {
        semester = model; // Change the content of that item
      }
    });

    calculateNewGPA();

    return <String, dynamic>{
      'data': model,
      'status_code': 200,
    };
  }

  Map<String, dynamic> deleteIt(QuerySemester q) {
    print(q.givenSemester);
    _dummyData['data']['all_semester_gpa'].removeWhere(
      (semester) => semester['given_semester'] == q.givenSemester,
    );

    calculateNewGPA();

    return <String, dynamic>{
      'data': 'Deleted successfully!',
      'status_code': 204,
    };
  }

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
}
