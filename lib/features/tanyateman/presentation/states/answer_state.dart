part of '_states.dart';

class AnswerState {
  final TextEditingController _answerController = TextEditingController();

  String? _answer;

  String get answer => _answer ?? '';

  void setReply(String newAnswer) {
    _answer = newAnswer;
  }
}
