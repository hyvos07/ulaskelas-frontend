part of '_states.dart';

class QuestionFormState {

  final TextEditingController _questionController = TextEditingController();

  String? _question;
  CourseModel? _course;
  bool _isAnonym = false;
  File? _image;

  String get question => _question ?? '';
  CourseModel? get course => _course;
  bool get isAnonym => _isAnonym;
  File? get image => _image;

  void setQuestion(String newQuestion){
    _question = newQuestion;
  }

  void setImage(File newFile) {
    _image = newFile;
  }

  void setCourse(CourseModel newCourse) {
    _course = newCourse;
  }

  void setIsAnonym(bool newIsAnonym) {
    _isAnonym = newIsAnonym;
  }
}
