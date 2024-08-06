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
    final pickedImg = await _imagePicker!.pickImage(
      source: ImageSource.gallery,);
    if (pickedImg != null) {
      final fileSizeInBytes = await pickedImg.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      
      if (fileSizeInMB <= 5) {
        final croppedImage = await cropImage(imageFile: File(pickedImg.path));
    
        setState(() {
          _fileImage = croppedImage;
        });
      } else {
        ErrorMessenger('Size of the image is more than 5 MB!').show(context);
      }
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    final croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
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
                  text: 'Pertanyaan', bottomPad: 10,
                ),
                const QuestionTextField(),
                const HeightSpace(15),
                CoursePicker(
                  onTap: () {
                    nav.goToSearchCourseRadioPick();
                  }
                ),
                const HeightSpace(20),
                const SendAsAnonymSwitcher(),
                const HeightSpace(20),
                ImagePickerBox(
                  onTap: pickImage,
                ),
                if (_fileImage != null)
                  Center(
                    child: Image.file(_fileImage!),
                  )
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
    componentFormRM.state.emptyScoreDetect();

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
      componentFormRM.state.emptyScoreDetect();
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
    componentFormRM.state.emptyScoreDetect();
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
    componentFormRM.state.emptyScoreDetect();
    nav.pop<void>();
    return true;
  }
}
