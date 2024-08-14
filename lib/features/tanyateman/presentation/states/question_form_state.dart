part of '_states.dart';

class QuestionFormState {
  QuestionFormState() {
    final remoteDataSource = QuestionRemoteDataSourceImpl();
    _repo = QuestionRepositoryImpl(remoteDataSource);
  }

  late QuestionRepository _repo; 

  final TextEditingController _questionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
  }

  void setImage(File newFile) {
    _fileImage = newFile;
  }

  void setCourse(CourseModel newCourse) {
    _course = newCourse;
    if (kDebugMode) {
      print('Course: ${_course!.name}');
    }
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

  Future<void> postNewQuestion() async {
    final model = {
      'attachment_file' : questionFormRM.state.fileImage,
      'course_id' : questionFormRM.state.course != null
        ? questionFormRM.state.course!.id : null,
      'question_text' : questionFormRM.state.questionController.text.trim(),
      'is_anonym' : questionFormRM.state.isAnonym
    };
    final resp = await _repo.postQuestion(model);
    await resp.fold((failure) {
      ErrorMessenger('Pertanyaan gagal dibuat')
          .show(ctx!);
    }, (result) async {
      SuccessMessenger('Pertanyaan berhasil dibuat').show(ctx!);
      _questionController.clear();
      _fileImage = null;
      _course = null;
      _isAnonym = false;
      // final calcResp = await _repo.getAllQuestions();
      // calcResp.fold((failure) => throw failure, (result) {
      //   final lessThanLimit = result.data.length < 10;
      //   hasReachedMax = result.data.isEmpty || lessThanLimit;
      //   _semesters = result.data;
      //   print(_semesters);
      // });
      nav.replaceToTanyaTemanPage();
    });
    semesterRM.notify();

  }
}
