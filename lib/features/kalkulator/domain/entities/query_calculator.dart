class QueryCalculator {
  int? courseId;

  QueryCalculator({
    this.courseId,
  });

  @override
  String toString() {
    final data = <String, String>{};
    data['id'] = courseId.toString();
    return Uri(queryParameters: data).query;
  }
}
