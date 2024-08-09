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
  final int createdAt; // unix timestamp (?)
  final String? attachmentUrl;

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
    this.attachmentUrl,
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
      attachmentUrl: json['attachment_url'],
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
    // data['attachment'] = attachment;
    data['likes'] = likes;
    data['answers'] = answers;
    data['created_at'] = createdAt;

    return data;
  }

  String get exactDateTime => DateFormat('dd MMM yyyy HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(createdAt * 1000));

  String get relativeDateTime {
    final now = DateTime.now();
    final created = DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);
    final diff = now.difference(created);

    final timeUnit = diff.inDays > 365
        ? 'years'
        : diff.inDays > 30
            ? 'months'
            : diff.inDays > 6
                ? 'weeks'
                : diff.inDays > 0
                    ? 'days'
                    : diff.inHours > 0
                        ? 'hours'
                        : diff.inMinutes > 0
                            ? 'minutes'
                            : 'seconds';

    switch (timeUnit) {
      case 'years':
        return diff.inDays ~/ 365 == 1
            ? 'a year ago'
            : '${diff.inDays ~/ 365} years ago';
      case 'months':
        return diff.inDays ~/ 30 == 1
            ? 'a month ago'
            : '${diff.inDays ~/ 30} months ago';
      case 'weeks':
        return diff.inDays ~/ 7 == 1
            ? 'a week ago'
            : '${diff.inDays ~/ 7} weeks ago';
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
