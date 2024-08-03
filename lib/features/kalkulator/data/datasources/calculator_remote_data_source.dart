part of '_datasources.dart';

abstract class CalculatorRemoteDataSource {
  String gpa = 0.toStringAsFixed(2);
  Future<Parsed<List<CalculatorModel>>> getAllCalculator(String givenSemester);
  Future<Parsed<Map<String, List<dynamic>>>> postCalculator(
    List<int> courseIds,
    String givenSemester,
  );
  Future<Parsed<void>> deleteCalculator(
    QueryCalculator q,
    String givenSemester,
  );
}

class CalculatorRemoteDataSourceImpl extends CalculatorRemoteDataSource {
  @override
  Future<Parsed<List<CalculatorModel>>> getAllCalculator(
    String givenSemester,
  ) async {
    final list = <CalculatorModel>[];
    final url = EndpointsRevamp.courses;
    final resp = await sendCustomRequest(
      url,
      method: 'GET',
      body: {
        'given_semester': givenSemester,
      },
    );
    for (final data in resp.dataBodyIterable['courses_calculator']) {
      list.add(CalculatorModel.fromJson(data, givenSemester));
    }
    if (resp.responseData['semester'] != null) {
      final semesterData = resp.responseData['semester'];
      super.gpa = semesterData['semester_gpa'].toStringAsFixed(2);
    }
    return resp.parse(list);
  }

  @override
  Future<Parsed<Map<String, List<dynamic>>>> postCalculator(
    List<int> courseIds,
    String givenSemester,
  ) async {
    final url = EndpointsRevamp.courses;
    final resp = await postIt(
      url,
      model: {
        'course_ids': courseIds,
        'given_semester': givenSemester,
      },
    );

    if (resp.responseData != null) {
      final dataResponse = <String, List<dynamic>>{
        'success': resp.responseData['inserted_course_ids'],
        'nonexist': resp.responseData['nonexistent_course_ids'],
        'duplicate':
            resp.responseData['duplicated_course_semester_ids'],
      };
      return resp.parse(dataResponse);
    }

    return resp.parse(resp.responseData);
  }

  @override
  Future<Parsed<void>> deleteCalculator(
    QueryCalculator q,
    String givenSemester,
  ) async {
    final url = '${EndpointsRevamp.courses}/${q.courseId}';
    final resp = await deleteIt(
      url,
      model: {
        'given_semester': givenSemester,
      },
    );
    return resp.parse(null);
  }
}
