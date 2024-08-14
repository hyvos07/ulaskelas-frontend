part of '_pages.dart';

class DetailQuestionPage extends StatefulWidget {
  const DetailQuestionPage({
    required this.model,
    super.key,
  });

  final QuestionModel model;

  @override
  _DetailQuestionPageState createState() => _DetailQuestionPageState();
}

class _DetailQuestionPageState extends BaseStateful<DetailQuestionPage> {
  int pageViewIndex = 0;
  double pageViewHeight = 0;
  late PageController _pageController;

  @override
  void init() {
    questionFormRM.setState((s) => s.clearForm());
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageViewIndex);
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null; // SliverAppBar will be used instead
  }

  void seeImage({
    bool isDetail = false,
  }) {
    if (isDetail) {
      nav.goToViewImagePage(
        CachedNetworkImageProvider(widget.model.attachmentUrl!),
        isDetail: isDetail,
      );
    } else {
      nav.goToViewImagePage(FileImage(questionFormRM.state.fileImage!));
    }
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: MediaQuery.of(context).size.width,
            leading: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.only(
                    left: 7.5,
                  ),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade900,
                  ),
                  onPressed: onBackPressed,
                ),
                Text(
                  '#${widget.model.courseName}',
                  style: FontTheme.poppins12w600black().copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            actions: [
              Icon(
                Icons.more_horiz,
                color: Colors.grey.shade900,
              ),
              const WidthSpace(20),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      PostContent(
                        model: widget.model,
                        isDetail: true,
                        onImageTap: () => seeImage(isDetail: true),
                      ),
                      const HeightSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const QuestionFormLabel(text: 'Komentar'),
                          Row(
                            children: [
                              const FilterIcon(
                                filterOn: true,
                              ),
                              QuestionFormLabel(
                                text: 'Filter',
                                color: BaseColors.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const HeightSpace(20),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: BaseColors.primary,
                    ),
                  ),
                ),
                const HeightSpace(10),
                ExpandablePageView.builder(
                    controller: _pageController,
                    animationDuration: const Duration(milliseconds: 500),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildShowComments();
                      }
                      return _buildCommentForm();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeightSpace(15),
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
        const HeightSpace(40),
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

  Widget _buildShowComments() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          child: Row(
            children: [
              UserProfileBox(name: profileRM.state.profile.name ?? ''),
              const WidthSpace(10),
              AskQuestionBox(
                onTap: () => _pageController.animateToPage(
                  1, // Index of the second page
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                isInDetailPage: true,
              ),
            ],
          ),
        ),
        const HeightSpace(10),
        Column(
          children: List.generate(16, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              child: CardPost(
                isReply: true,
                model: widget.model,
              ),
            );
          }),
        )
      ]),
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
      await componentFormRM.state.submitForm(1);
      await Future.delayed(const Duration(milliseconds: 150));

      nav.pop();

      final averageScore = componentFormRM.state.averageScore();
      final weight = componentFormRM.state.formData.weight!;

      componentFormRM.state.cleanForm();
      if (kDebugMode) {
        print('success');
      }

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
    questionFormRM.state.clearForm();
    nav.pop<void>();
    return true;
  }
}
