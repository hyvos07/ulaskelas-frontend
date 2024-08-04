part of '_pages.dart';

class NewQuestionFormPage extends StatefulWidget {
  const NewQuestionFormPage({
    super.key,
  });


  @override
  _NewQuestionFormPageState createState() => _NewQuestionFormPageState();
}

class _NewQuestionFormPageState extends BaseStateful<NewQuestionFormPage> {
  bool isAnonym = false;

  @override
  void init() {
    componentFormRM.setState((s) => s.cleanForm());
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.frequency.text = '1';
    componentFormRM.state.justVisited = true;

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
              children: const [
                QuestionFormLabel(
                  text: 'Pertanyaan', bottomPad: 10,
                ),
                QuestionTextField(),
                HeightSpace(10),
                // TODO: dropdown select matkul
                HeightSpace(20),
                SendAsAnonymSwitcher(),
                HeightSpace(20),
                ImagePickerBox()
              ],
            ),
          ),
        ),
        OnReactive(
          () => PostButton(
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
