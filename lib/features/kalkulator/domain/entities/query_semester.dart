class QuerySemester {
  String? givenSemester;

  QuerySemester({
    this.givenSemester,
  });

  @override
  String toString() {
    final data = <String, String>{};
    data['given_semester'] = givenSemester!;
    return Uri(queryParameters: data).query;
  }
}
