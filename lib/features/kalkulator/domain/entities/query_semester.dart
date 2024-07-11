class QuerySemester {
  int? givenSemester;

  QuerySemester({
    this.givenSemester,
  });

  @override
  String toString() {
    final data = <String, String>{};
    data['given_semester'] = givenSemester.toString();
    return Uri(queryParameters: data).query;
  }
}
