part of '_pages.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({
    super.key,
  });

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends BaseStateful<AddQuestionPage> {
  @override
  void init() {
    questionFormRM.setState((s) => s.clearForm());
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

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: questionFormRM.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const QuestionFormLabel(
                  text: 'Pertanyaan',
                  bottomPad: 10,
                ),
                QuestionTextField(
                  controller: questionFormRM.state.questionController,
                  onChanged: (value) {
                    if (value.trim().isEmpty) {
                      questionFormRM.state.questionController.text = '';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    questionFormRM.setState((s) => s.setQuestion(value));
                    return null;
                  },
                ),
                const HeightSpace(15),
                CoursePicker(
                  onTap: () {
                    nav.goToSearchCourseRadioPick();
                  },
                ),
                const HeightSpace(20),
                OnBuilder<QuestionFormState>.all(
                  listenTo: questionFormRM,
                  onIdle: WaitingView.new,
                  onWaiting: WaitingView.new,
                  onError: (dynamic error, refresh) => Text(error.toString()),
                  onData: (data) {
                    return SendAsAnonymSwitcher(
                      isAnonym: questionFormRM.state.isAnonym,
                      onChanged: questionFormRM.state.setIsAnonym,
                    );
                  },
                ),
                const HeightSpace(20),
                OnBuilder<QuestionFormState>.all(
                  listenTo: questionFormRM,
                  onIdle: WaitingView.new,
                  onWaiting: WaitingView.new,
                  onError: (dynamic error, refresh) => Text(error.toString()),
                  onData: (data) {
                    return ImagePickerBox(
                      onTapUpload: questionFormRM.state.pickImage,
                      onTapSeeImage: seeImage,
                      isImageSizeTooBig: questionFormRM.state.isImageSizeTooBig,
                    );
                  },
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

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    questionFormRM.state.clearForm();
    nav.pop<void>();
    return true;
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

  void seeImage() {
    nav.goToViewImagePage(FileImage(questionFormRM.state.fileImage!));
  }
}
