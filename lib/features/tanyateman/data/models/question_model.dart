part of '_models.dart';

class QuestionModel {
  final int id;
  final String userFullName;
  final String userMajor;
  final String userGeneration;
  final String tags;
  final String question;
  final int likes;
  final int answers;
  final int createdAt; // Milliseconds since epoch

  QuestionModel({
    required this.id,
    required this.userFullName,
    required this.userMajor,
    required this.userGeneration,
    required this.tags,
    required this.question,
    required this.likes,
    required this.answers,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      userFullName: json['user_full_name'],
      userMajor: json['user_major'],
      userGeneration: json['user_generation'],
      tags: json['tags'],
      question: json['question'],
      likes: json['likes'],
      answers: json['answers'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    
    data['id'] = id;
    data['user_full_name'] = userFullName;
    data['user_major'] = userMajor;
    data['user_generation'] = userGeneration;
    data['tags'] = tags;
    data['question'] = question;
    data['likes'] = likes;
    data['answers'] = answers;
    data['created_at'] = createdAt;
    
    return data;
  }

  String get exactDateTime => DateFormat('dd MMM yyyy HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(createdAt));

  String get relativeDateTime {
    final now = DateTime.now();
    final created = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final diff = now.difference(created);

    final timeUnit = diff.inDays > 0
        ? 'days'
        : diff.inHours > 0
            ? 'hours'
            : diff.inMinutes > 0
                ? 'minutes'
                : 'seconds';

    switch (timeUnit) {
      case 'days':
        return diff.inDays == 1 ? 'a day ago' : '${diff.inDays} days ago';
      case 'hours':
        return diff.inHours == 1 ? 'an hour ago' : '${diff.inHours} hours ago';
      case 'minutes':
        return diff.inMinutes == 1
            ? 'a minute ago'
            : '${diff.inMinutes} minutes ago';
      default:
        return 'Just now'; // Under 1 minute
    }
  }
}
