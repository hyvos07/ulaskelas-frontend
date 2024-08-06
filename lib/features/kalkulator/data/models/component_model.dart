class ComponentModel {
  int? id;
  int? calculatorId;
  String? name;
  double? weight;
  double? score;
  int? frequency;
  List<double?>? scores;
  double? recommendedScore;

  ComponentModel({
    this.id,
    this.calculatorId,
    this.name,
    this.weight,
    this.score,
    this.frequency,
    this.scores,
  });

  ComponentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calculatorId = json['calculator_id'];
    name = json['name'];
    weight = json['weight'];
    score = json['score'] == -1 ? -1.00 : json['score'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['calculator_id'] = calculatorId;
    data['name'] = name;
    data['weight'] = weight;
    data['score'] = score;
    data['frequency'] = frequency;
    data['scores'] = scores;
    data['recommended_score'] = recommendedScore;
    return data;
  }
}
