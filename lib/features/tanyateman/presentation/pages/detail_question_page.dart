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
    bool isReply = false,
    String? replyId,
  }) {
    if (isDetail) {
      nav.goToViewImagePage(
        CachedNetworkImageProvider(widget.model.attachmentUrl!),
        imageTag: 'post-image-preview?id=${widget.model.id}',
        enableImagePreview: isDetail,
      );
    } else if (isReply) {
      nav.goToViewImagePage(
        CachedNetworkImageProvider(widget.model.attachmentUrl!),
        imageTag: 'reply-image-preview?id=$replyId',
        enableImagePreview: isReply,
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
                Expanded(
                  child: Text('#${widget.model.courseName}',
                      style: FontTheme.poppins12w600black().copyWith(
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis),
                ),
                const WidthSpace(20),
                Icon(
                  Icons.more_horiz,
                  color: Colors.grey.shade900,
                ),
                const WidthSpace(20),
              ],
            ),
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
                        imageTag: 'post-image-preview?id=${widget.model.id}',
                      ),
                    ],
                  ),
                ),
                const HeightSpace(30),
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
                    animationDuration: const Duration(milliseconds: 800),
                    animationCurve: Curves.fastLinearToSlowEaseIn,
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
              const HeightSpace(5),
              const QuestionFormLabel(
                text: 'Jawaban',
                bottomPad: 10,
              ),
              QuestionTextField(
                isAnswer: true,
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
              SendAsAnonymSwitcher(
                isAnonym: questionFormRM.state.isAnonym,
                onChanged: questionFormRM.state.setIsAnonym,
              ),
              const HeightSpace(20),
              ImagePickerBox(
                onTapUpload: questionFormRM.state.pickImage,
                onTapSeeImage: seeImage,
                isImageSizeTooBig: questionFormRM.state.isImageSizeTooBig,
              )
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
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
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
                imageTag: 'reply-image-preview?id=$index',
                onRefreshImage: () {}, // NOTE: pake statenyaReplies.refresh()
                onImageTap: () => seeImage(
                  isReply: true,
                  replyId: index.toString(), // change this to the real reply id
                ),
                optionChoices: const ['Report'],
                onOptionChoosed: (value) {
                  if (value == 'Report') {
                    print('report reply!');
                    // report reply here
                  }
                },
              ),
            );
          }),
        )
      ]),
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {}

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
