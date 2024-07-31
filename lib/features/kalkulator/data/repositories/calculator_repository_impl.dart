part of '_repositories.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  CalculatorRepositoryImpl(
    this._remoteDataSource,
  );
  final CalculatorRemoteDataSource _remoteDataSource;
  
  @override
  String get gpa => _remoteDataSource.gpa;

  @override
  Future<Decide<Failure, Parsed<List<CalculatorModel>>>> getAllCalculator(
    String givenSemester,
  ) {
    return apiCall(_remoteDataSource.getAllCalculator(givenSemester));
  }

  @override
  Future<Decide<Failure, Parsed<Map<String, List<dynamic>>>>> postCalculator(
    List<int> courseIds,
    String givenSemester,
  ) {
    return apiCall(_remoteDataSource.postCalculator(courseIds, givenSemester));
  }

  @override
  Future<Decide<Failure, Parsed<void>>> deleteCalculator(
    QueryCalculator q,
    String givenSemester,
  ) {
    return apiCall(_remoteDataSource.deleteCalculator(q, givenSemester));
  }
}
