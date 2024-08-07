part of '_repositories.dart';

abstract class ComponentRepository {
  Future<Decide<Failure, Parsed<Map<String, dynamic>>>> getAllComponent(
    QueryComponent q,
  );
  Future<Decide<Failure, Parsed<Map<String, dynamic>>>> getDetailComponent(
    QueryComponent q,
  );
  Future<Decide<Failure, Parsed<ComponentModel>>> createComponent(
    Map<String, dynamic> model,
  );
  Future<Decide<Failure, Parsed<ComponentModel>>> editComponent(
    Map<String, dynamic> model,
  );
  Future<Decide<Failure, Parsed<void>>> deleteComponent(QueryComponent q);
}
