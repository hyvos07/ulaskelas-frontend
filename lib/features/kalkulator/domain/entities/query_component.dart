class QueryComponent {
  int? id;
  int? calculatorId;
  int? scoreComponentId;

  QueryComponent({
    this.calculatorId,
    this.id,
    this.scoreComponentId,
  });

  @override
  String toString() {
    final data = <String, String>{};
    if (calculatorId != null) {
      data['calculator_id'] = calculatorId.toString();
    }
    if (id != null) {
      data['id'] = id.toString();
    }
    if (scoreComponentId != null) {
      data['score_component_id'] = scoreComponentId.toString();
    }
    return Uri(queryParameters: data).query;
  }
}
