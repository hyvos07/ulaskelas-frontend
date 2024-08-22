part of '_states.dart';

class AnswerFormState {
  AnswerFormState() {
    final remoteDataSource = AnswerRemoteDataSourceImpl();
    _repo = AnswerRepositoryImpl(remoteDataSource);
    _answerController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  late AnswerRepository _repo; 
  late TextEditingController _answerController;
  late GlobalKey formKey;

  String? _answer;
  bool _isAnonym = false;
  File? _fileImage;
  ImagePicker? _imagePicker;
  bool? isImageSizeTooBig;

  String get answer => _answer ?? '';
  TextEditingController get answerController => _answerController;
  bool get isAnonym => _isAnonym;
  File? get fileImage => _fileImage;
  ImagePicker? get imagePicker => _imagePicker;

  void clearForm() {
    _answerController.clear();
    _answer = '';
    _isAnonym = false;
    _fileImage = null;
    _imagePicker = ImagePicker();
    isImageSizeTooBig = null;

    if (kDebugMode) {
      print('Form Cleared');
    }

    answerFormRM.notify();
  }

  void setAnswer(String newAnswer) {
    _answer = newAnswer;
    answerFormRM.notify();
  }

  void setImage(File newFile) {
    _fileImage = newFile;
    answerFormRM.notify();
  }

  void setIsAnonym(bool newIsAnonym) {
    _isAnonym = newIsAnonym;
    if (kDebugMode) {
      print('Is Anonym: $_isAnonym');
    }
    answerFormRM.notify();
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

    answerFormRM.notify();
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

  Future<bool> postNewAnswer(int id) async {
    var isSucces = false;

    final model = {
      'question_id' : id,
      'attachment_file' : fileImage,
      'answer_text' : answerController.text.trim(),
      'is_anonym' : isAnonym == true
        ? '1' : '0'
    };

    if (fileImage == null) model.remove('attachment_file');

    final resp = await _repo.postAnswer(model);
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