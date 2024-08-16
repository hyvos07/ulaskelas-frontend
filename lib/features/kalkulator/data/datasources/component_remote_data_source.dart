part of '_datasources.dart';

abstract class ComponentRemoteDataSource {
  Future<Parsed<Map<String, dynamic>>> getAllComponent(QueryComponent q);

  Future<Parsed<Map<String, dynamic>>> getDetailComponent(QueryComponent q);

  Future<Parsed<ComponentModel>> createComponent(Map<String, dynamic> model);

  Future<Parsed<ComponentModel>> editComponent(Map<String, dynamic> model);

  Future<Parsed<void>> deleteComponent(QueryComponent q);
}

class ComponentRemoteDataSourceImpl extends ComponentRemoteDataSource {
  @override
  Future<Parsed<Map<String, dynamic>>> getAllComponent(QueryComponent q) async {
    // di q bisa aja dateng '&target_score=??? nanti dipertimbangkan lagi
    final list = <ComponentModel>[];
    var url = '${EndpointsRevamp.components}?$q';
    var resp = await getIt(url);
    final maxPossibleScore = resp.dataBodyAsMap['max_possible_score'];

    var ts = 85; // default target score
    if (maxPossibleScore < ts && q.targetScore == null){
      while (ts > maxPossibleScore && ts >= 55) {ts -= 5;}
      final id = q.calculatorId;
      url = '${EndpointsRevamp.components}?calculator_id=$id&target_score=$ts';
      resp = await getIt(url);
    }

    for (final data in resp.dataBodyIterable['score_component']) {
      list.add(ComponentModel.fromJson(data));
    }

    final result = {
      'recommended_score': resp.dataBodyAsMap['recommended_score'],
      'max_possible_score' : resp.dataBodyAsMap['max_possible_score'],
      'components': list,
    };

    return resp.parse(result);
  }

  @override
  Future<Parsed<Map<String, dynamic>>> getDetailComponent(
    QueryComponent q,
  ) async {
    final url = '${EndpointsRevamp.subcomponents}?$q';
    final resp = await getIt(url);

    final detail = {
      'frequency': resp.dataBodyAsMap['list_subcomponent_score'].length,
      'scores': resp.dataBodyAsMap['list_subcomponent_score'],
      'recommended_score': resp.dataBodyAsMap['recommended_score'],
    };

    return resp.parse(detail);
  }

  @override
  Future<Parsed<ComponentModel>> createComponent(
    Map<String, dynamic> model,
  ) async {
    final url = EndpointsRevamp.subcomponents;
    final resp = await postIt(url, model: model);
    return resp.parse(ComponentModel.fromJson(resp.dataBodyAsMap));
  }

  @override
  Future<Parsed<ComponentModel>> editComponent(
    Map<String, dynamic> model,
  ) async {
    final url = EndpointsRevamp.subcomponents;
    final resp = await putIt(url, model: model);
    return resp.parse(ComponentModel.fromJson(resp.dataBodyAsMap));
  }

  @override
  Future<Parsed<void>> deleteComponent(QueryComponent q) async {
    final url = '${EndpointsRevamp.components}?$q';
    final resp = await deleteIt(url);
    return resp.parse(null);
  }
}
