part of '_pages.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({
    super.key,
  });

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends BaseStateful<AddQuestionPage> {
  bool isAnonym = false;
  File? _fileImage;
  ImagePicker? _imagePicker;
  bool? _isImageSizeTooBig;

  @override
  void init() {
    componentFormRM.setState((s) => s.cleanForm());
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.frequency.text = '1';
    componentFormRM.state.justVisited = true;
    _imagePicker = ImagePicker();
    // print(componentFormRM.state.scoreControllers);
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'TanyaTeman',
      onBackPress: onBackPressed,
    );
  }

  Future<void> pickImage() async {
    final pickedImg =
        await _imagePicker!.pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      final fileSizeInBytes = await pickedImg.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB <= 5) {
        final croppedImage = await cropImage(imageFile: File(pickedImg.path));

        if (croppedImage != null) {
          setState(() {
            _fileImage = croppedImage;
            _isImageSizeTooBig = false;
          });
        }
      } else {
        setState(() {
          _isImageSizeTooBig = true;
        });
      }
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    final croppedImage =
        await ImageCropper().cropImage(
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

  void seeImage() {
    nav.goToViewImagePage(FileImage(_fileImage!));
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: componentFormRM.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const QuestionFormLabel(
                  text: 'Pertanyaan',
                  bottomPad: 10,
                ),
                const QuestionTextField(),
                const HeightSpace(15),
                CoursePicker(
                  onTap: () {
                    nav.goToSearchCourseRadioPick();
                  },
                ),
                const HeightSpace(20),
                const SendAsAnonymSwitcher(),
                const HeightSpace(20),
                ImagePickerBox(
                  onTapUpload: pickImage,
                  onTapSeeImage: seeImage,
                  isImageSizeTooBig: _isImageSizeTooBig,
                ),
              ],
            ),
          ),
        ),
        OnReactive(
          () => ExpandedButton(
            isLoading: componentFormRM.state.isLoading,
            text: 'Posting',
            onTap: () async {
              await onSubmitCallBack(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);
    componentFormRM.state.justVisited = false;

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }
    MixpanelService.track('calculator_add_course_component');
    if (componentFormRM.state.formKey.currentState!.validate() &&
        !componentFormRM.state.scoreControllers
            .any((element) => element.text.isEmpty)) {
      // progressDialogue(context);
      await componentFormRM.state.submitForm(1);
      await Future.delayed(const Duration(milliseconds: 150));

      nav.pop();

      final averageScore = componentFormRM.state.averageScore();
      final weight = componentFormRM.state.formData.weight!;

      componentFormRM.state.cleanForm();
      if (kDebugMode) {
        print('success');
      }

      // await nav.replaceToComponentPage(
      //   givenSemester: widget.givenSemester,
      //   courseId: widget.courseId,
      //   calculatorId: widget.calculatorId,
      //   courseName: widget.courseName,
      //   totalScore: _temporaryUpdateScore(
      //     averageScore,
      //     weight,
      //   ),
      //   totalPercentage: _temporaryUpdateWeight(
      //     weight,
      //   ),
      // );

      return;
    }

    WarningMessenger('Pastikan semua field sudah terisi dengan benar!')
        .show(context);
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.cleanForm();
    nav.pop<void>();
    return true;
  }
}
