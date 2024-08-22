part of '_states.dart';

class QuestionFormState {
  QuestionFormState() {
    final remoteDataSource = QuestionRemoteDataSourceImpl();
    _repo = QuestionRepositoryImpl(remoteDataSource);
    _questionController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  late QuestionRepository _repo; 
  late TextEditingController _questionController;
  late GlobalKey formKey;

  String? _question;
  CourseModel? _course;
  bool _isAnonym = false;
  File? _fileImage;
  ImagePicker? _imagePicker;
  bool? isImageSizeTooBig;

  String get question => _question ?? '';
  TextEditingController get questionController => _questionController;
  CourseModel? get course => _course;
  bool get isAnonym => _isAnonym;
  File? get fileImage => _fileImage;
  ImagePicker? get imagePicker => _imagePicker;

  void clearForm() {
    _questionController.clear();
    _question = '';
    _course = null;
    _isAnonym = false;
    _fileImage = null;
    _imagePicker = ImagePicker();
    isImageSizeTooBig = null;

    if (kDebugMode) {
      print('Form Cleared');
    }

    questionFormRM.notify();
  }

  void setQuestion(String newQuestion) {
    _question = newQuestion;
    questionFormRM.notify();
  }

  void setImage(File newFile) {
    _fileImage = newFile;
    questionFormRM.notify();
  }

  void setCourse(CourseModel newCourse) {
    _course = newCourse;
    if (kDebugMode) {
      print('Course: ${_course!.name}');
    }
    questionFormRM.notify();
  }
  void clearCourse() {
    _course = null;
    if (kDebugMode) {
      print('No selected course');
    }
    questionFormRM.notify();
  }

  void setIsAnonym(bool newIsAnonym) {
    _isAnonym = newIsAnonym;
    if (kDebugMode) {
      print('Is Anonym: $_isAnonym');
    }
    questionFormRM.notify();
  }

  Future<void> pickImage() async {
    final pickedImg = await _imagePicker!.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImg != null) {
      final fileSizeInBytes = await pickedImg.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB <= 5) {
        final croppedImage = await cropImage(imageFile: File(pickedImg.path));

        if (croppedImage != null) {
          setImage(croppedImage);
          isImageSizeTooBig = false;
        }
      } else {
        isImageSizeTooBig = true;
      }
    }

    questionFormRM.notify();
  }

  Future<File?> cropImage({required File imageFile}) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.grey.shade600,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
          minimumAspectRatio: 1,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<bool> postNewQuestion() async {
    var isSucces = false;

    final model = {
      'attachment_file' : fileImage,
      'course_id' : course != null
        ? '${course!.id}' : null,
      'question_text' : questionController.text.trim(),
      'is_anonym' : isAnonym == true
        ? '1' : '0'
    };
    if (questionFormRM.state.fileImage == null) model.remove('attachment_file');

    final resp = await _repo.postQuestion(model);
    await resp.fold((failure) {
      isSucces = false;
    }, (result) async {
      clearForm();
      isSucces = true;
    });
    answerFormRM.notify();

    return isSucces;
  }
}
