part of '_datasources.dart';

abstract class ComponentRemoteDataSource {
  Future<Parsed<List<ComponentModel>>> getAllComponent(QueryComponent q);

  Future<Parsed<Map<String, dynamic>>> getDetailComponent(QueryComponent q);

  Future<Parsed<ComponentModel>> createComponent(Map<String, dynamic> model);

  Future<Parsed<ComponentModel>> editComponent(Map<String, dynamic> model);

  Future<Parsed<void>> deleteComponent(QueryComponent q);
}

class ComponentRemoteDataSourceImpl extends ComponentRemoteDataSource {
  @override
  Future<Parsed<List<ComponentModel>>> getAllComponent(QueryComponent q) async {
    final list = <ComponentModel>[];
    final url = '${EndpointsRevamp.components}?$q';
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable['score_component']) {
      list.add(ComponentModel.fromJson(data));
    }
    return resp.parse(list);
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
