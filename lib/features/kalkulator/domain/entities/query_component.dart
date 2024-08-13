class QueryComponent {
  int? id;
  int? calculatorId;
  int? scoreComponentId;
  int? targetScore;

  QueryComponent({
    this.calculatorId,
    this.id,
    this.scoreComponentId,
    this.targetScore
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
    if (targetScore != null) {
      data['target_score'] = targetScore.toString();
    }
    return Uri(queryParameters: data).query;
  }
}
