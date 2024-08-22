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

  late ScrollController scrollController;
  Completer<void>? completer;

  @override
  void init() {
    answerFormRM.setState((s) => s.clearForm());
    scrollController = ScrollController();
    completer = Completer<void>();
    scrollController.addListener(_onScroll);
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      cacheKey: 'detail-question',
      state: false,
    ).initialize();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageViewIndex);
  }

  void _onScroll() {
    if (_isBottom && !completer!.isCompleted && scrollCondition()) {
      print('${scrollCondition()}');
      onScroll();
    }
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
      nav.goToViewImagePage(FileImage(answerFormRM.state.fileImage!));
    }
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: retrieveData,
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
                          questionModel: widget.model,
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
                controller: answerFormRM.state.answerController,
                onChanged: (value) {
                  if (value.trim().isEmpty) {
                    answerFormRM.state.answerController.text = '';
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required.';
                  }
                  answerFormRM.setState((s) => s.setAnswer(value));
                  return null;
                },
              ),
              const HeightSpace(20),
              OnReactive(() 
                => SendAsAnonymSwitcher(
                  isAnonym: answerFormRM.state.isAnonym,
                  onChanged: answerFormRM.state.setIsAnonym,
                ),
              ),
              const HeightSpace(20),
              OnReactive(() 
                => ImagePickerBox(
                  onTapUpload: answerFormRM.state.pickImage,
                  onTapSeeImage: seeImage,
                  isImageSizeTooBig: answerFormRM.state.isImageSizeTooBig,
                ),
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
        OnBuilder<AnswerState>.all(
          listenTo: answersRM,
          onWaiting: () => Column(
            children: List.generate(
              10,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SkeletonCardPost(
                  isReply: true,
                ),
              ),
            ),
          ),
          onIdle: () => Column(
            children: List.generate(
              10,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SkeletonCardPost(
                  isReply: true,
                ),
              ),
            ),
          ),
          onError: (dynamic error, refresh) =>
              Text(error.toString()),
          onData: (data) {
            return answersRM.state.allAnswer.isEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Tidak ada apa-apa disini.',
                    style:
                        FontTheme.poppins12w600black().copyWith(
                      color: BaseColors.gray2.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
                  children : data.allAnswer.map((answer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                      child: CardPost(
                        isReply: true,
                        answerModel: answer,
                        imageTag: 'reply-image-preview?id=${answer.id}',
                        onRefreshImage: () {}, // NOTE: pake statenyaReplies.refresh()
                        onImageTap: () => seeImage(
                          isReply: true,
                          replyId: answer.id.toString(), // change this to the real reply id
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
                  }).toList(),
                );
          }
        )
      ]),
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    if (answerFormRM.state.answerController.text != '') {
      final isSucces = await answerFormRM.state.postNewAnswer(widget.model.id);
      if (isSucces) {
        await _pageController.animateToPage(
          0, // Index of the second page
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
        );
        SuccessMessenger('Jawaban berhasil dibuat').show(ctx!);
      } else {
        ErrorMessenger('Jawaban gagal dibuat').show(ctx!);
      }
    } else {
      WarningMessenger('Jawaban perlu diisi!').show(context);
    }
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
    answerFormRM.state.clearForm();
    nav.pop<void>();
    return true;
  }


  ///////////////////////////
  ///////////////////////////
  ///////////////////////////
  


  Future<void> onScroll() async {
    completer?.complete();
    final query = QueryAnswer();
    await answersRM.state.retrieveMoreAllAnswer(query).then((value) {
      completer = Completer<void>();
      answersRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  Future<void> retrieveData() async {
    final query = QueryAnswer(questionId: widget.model.id);
    await answersRM.setState((s) => s.retrieveAllAnswer(query));
  }

  bool scrollCondition() {
    return !answersRM.state.hasReachedMax;
  }

  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool get _isBottom {
    if (!scrollController.hasClients) {
      if (kDebugMode) print('no client');
      return false;
    }
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    print(currentScroll >= (maxScroll * 0.95));
    return currentScroll >= (maxScroll * 0.95);
  }

}
