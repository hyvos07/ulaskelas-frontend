part of '_models.dart';

class QuestionModel {
  final int id;
  final String userName;
  final String userProgram;
  final String userGeneration;
  final String questionText;
  final int courseId;
  final String courseName;
  final bool isAnonym;
  int likeCount;
  int replyCount;
  final String createdAt;
  final String? verificationStatus;
  final String? attachmentUrl;

  QuestionModel({
    required this.id,
    required this.userName,
    required this.userProgram,
    required this.userGeneration,
    required this.questionText,
    required this.courseId,
    required this.courseName,
    required this.isAnonym,
    required this.likeCount,
    required this.replyCount,
    required this.createdAt,
    this.verificationStatus,
    this.attachmentUrl,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      userName: json['user']['name'],
      userProgram: json['user']['program'],
      userGeneration: json['user']['generation'],
      questionText: json['question_text'],
      courseId: json['course']['id'],
      courseName: json['course']['name'],
      isAnonym: json['is_anonym'] == 1,
      likeCount: json['like_count'],
      replyCount: json['reply_count'],
      createdAt: json['created_at'],
      verificationStatus: json['verification_status'],
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
    data['question_text'] = questionText;
    data['course'] = {
      'id': courseId,
      'name': courseName,
    };
    data['is_anonym'] = isAnonym ? 1 : 0;
    data['like_count'] = likeCount;
    data['reply_count'] = replyCount;
    data['created_at'] = createdAt;
    // data['verification_status'] = verificationStatus;
    // data['attachment_url'] = attachmentUrl;

    return data;
  }

  String get exactDateTime => DateFormat('dd MMM yyyy HH:mm')
      .format(DateTime.parse(createdAt).toLocal());

  // String get relativeDateTime {
  //   final now = DateTime.now();
  //   final created = DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);
  //   final diff = now.difference(created);

  //   final timeUnit = diff.inDays > 365
  //       ? 'years'
  //       : diff.inDays > 30
  //           ? 'months'
  //           : diff.inDays > 6
  //               ? 'weeks'
  //               : diff.inDays > 0
  //                   ? 'days'
  //                   : diff.inHours > 0
  //                       ? 'hours'
  //                       : diff.inMinutes > 0
  //                           ? 'minutes'
  //                           : 'seconds';

  //   switch (timeUnit) {
  //     case 'years':
  //       return diff.inDays ~/ 365 == 1
  //           ? 'a year ago'
  //           : '${diff.inDays ~/ 365} years ago';
  //     case 'months':
  //       return diff.inDays ~/ 30 == 1
  //           ? 'a month ago'
  //           : '${diff.inDays ~/ 30} months ago';
  //     case 'weeks':
  //       return diff.inDays ~/ 7 == 1
  //           ? 'a week ago'
  //           : '${diff.inDays ~/ 7} weeks ago';
  //     case 'days':
  //       return diff.inDays == 1 ? 'a day ago' : '${diff.inDays} days ago';
  //     case 'hours':
  //       return diff.inHours == 1 ? 'an hour ago' : '${diff.inHours} hours ago';
  //     case 'minutes':
  //       return diff.inMinutes == 1
  //           ? 'a minute ago'
  //           : '${diff.inMinutes} minutes ago';
  //     default:
  //       return 'Just now'; // Under 1 minute
  //   }
  // }
}
