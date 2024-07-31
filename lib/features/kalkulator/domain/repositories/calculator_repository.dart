part of '_repositories.dart';

abstract class CalculatorRepository {
  String get gpa;

  Future<Decide<Failure, Parsed<List<CalculatorModel>>>> getAllCalculator(
    String givenSemester,
  );
  Future<Decide<Failure, Parsed<Map<String, List<dynamic>>>>> postCalculator(
    List<int> courseIds,
    String givenSemester,
  );
  Future<Decide<Failure, Parsed<void>>> deleteCalculator(
    QueryCalculator q,
    String givenSemester,
  );
}
