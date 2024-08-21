part of '_models.dart';

class AnswerModel {
  final int id;
  final int questionId;
  final String userName;
  final String userProgram;
  final String userGeneration;
  final String answerText;
  final bool isAnonym;
  final int likeCount;
  final String createdAt;
  final String? attachmentUrl;

  AnswerModel({
    required this.id,
    required this.userName,
    required this.userProgram,
    required this.userGeneration,
    required this.questionId,
    required this.answerText,
    required this.isAnonym,
    required this.likeCount,
    required this.createdAt,
    this.attachmentUrl,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      questionId: json['question_id'],
      userName: json['user']['name'],
      userProgram: json['user']['program'],
      userGeneration: json['user']['generation'],
      answerText: json['answer_text'],
      isAnonym: json['is_anonym'] == 1,
      likeCount: json['like_count'],
      createdAt: json['created_at'],
      attachmentUrl: !(json['attachment_url'] ?? '').contains('.pdf')
          ? json['attachment_url']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    // NOTE: Nanti sesuaiin aja sama API nya
    data['id'] = id;
    data['user'] = {
      'name': userName,
      'program': userProgram,
      'generation': userGeneration,
    };
    data['answer_text'] = answerText;
    data['is_anonym'] = isAnonym ? 1 : 0;
    data['like_count'] = likeCount;
    data['created_at'] = createdAt;
    data['question_id'] = questionId;
    return data;
  }

  String get exactDateTime => DateFormat('dd MMM yyyy HH:mm')
      .format(DateTime.parse(createdAt).toLocal());
}