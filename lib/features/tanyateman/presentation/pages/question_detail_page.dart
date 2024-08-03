part of '_pages.dart';

class QuestionDetailPage extends StatefulWidget {
  const QuestionDetailPage({
    super.key,
  });


  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends BaseStateful<QuestionDetailPage> {
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
      elevation: 0,
      onBackPress: onBackPressed,
      label: '#Struktur Data dan Algoritma',
      style: FontTheme.poppins14w400black() 
        .copyWith(color: Colors.grey.shade700),
      centerTitle: false,
      actions: [
        Icon(Icons.more_horiz, color: Colors.grey.shade700,),
        const WidthSpace(20)
      ],
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                PostContent(),
                HeightSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuestionFormLabel(text: 'Komentar'),
                    Row(
                      children: [
                        Icon(Icons.filter_alt, size: 17.5,),
                        QuestionFormLabel(text: 'Filter'),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const HeightSpace(20),
          const DotIndicator(
            currentIndex: 0, 
            length: 1
          ),
          const HeightSpace(10),
          SizedBox(
            height: 100000,
            child: PageView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildShowComments();
                }
                return _buildCommentForm();
              },
            ),
          )
        ],
      ),
    );
  }


  Widget _buildCommentForm() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionFormLabel(
                text: 'Pertanyaan', bottomPad: 10,
              ),
              QuestionTextField(),
              HeightSpace(20),
              // TODO: dropdown select matkul
              HeightSpace(20),
              SendAsAnonymSwitcher(),
              HeightSpace(20),
              ImagePickerBox()
            ],
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

  Widget _buildShowComments() {
    return Column(
      children: List.generate(10, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18, vertical: 5
          ),
          child: CardPost(),
        );
      }),
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
