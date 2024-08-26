part of '_pages.dart';

class DetailQuestionPage extends StatefulWidget {
  const DetailQuestionPage({
    required this.model,
    this.toReply = false,
    this.fromSearch = false,
    super.key,
  });

  final QuestionModel model;
  final bool toReply;
  final bool fromSearch;

  @override
  _DetailQuestionPageState createState() => _DetailQuestionPageState();
}

class _DetailQuestionPageState extends BaseStateful<DetailQuestionPage> {
  int pageViewIndex = 0;
  double pageViewHeight = 0;
  late PageController _pageController;

  late ScrollController scrollController;
  Completer<void>? completer;

  double lastScrollPosition = 0;

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
    _pageController.addListener(_onPageChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // TODO(any): find a better approach
      await Future.delayed(const Duration(milliseconds: 1000));
      if (_pageController.hasClients && widget.toReply) {
        print('Animating to page 1');
        await _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _onPageChanged() {
    if (_pageController.page == 0) {
      scrollController.animateTo(
        lastScrollPosition,
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    }
  }

  void _onScroll() {
    if (_pageController.page == 0) {
      lastScrollPosition = scrollController.offset; // Save scroll position
    }

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
    String? replyUrlFile,
  }) {
    if (isDetail) {
      nav.goToViewImagePage(
        CachedNetworkImageProvider(widget.model.attachmentUrl!),
        imageTag: 'post-image-preview?id=${widget.model.id}',
        enableImagePreview: isDetail,
      );
    } else if (isReply) {
      nav.goToViewImagePage(
        CachedNetworkImageProvider(replyUrlFile!),
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
          controller: scrollController,
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
                    child: Text(
                      '#${widget.model.courseName}',
                      style: FontTheme.poppins12w600black().copyWith(
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                        OnBuilder(
                          listenTo: questionsRM,
                          builder: () => PostContent(
                            onLikeTap: () async {
                              await questionsRM.state
                                  .likeQuestion(widget.model);
                              if (widget.fromSearch) {
                                searchQuestionRM.notify();
                              }
                            },
                            questionModel: widget.model,
                            isDetail: true,
                            onImageTap: () => seeImage(isDetail: true),
                            imageTag:
                                'post-image-preview?id=${widget.model.id}',
                            onReplyTap: () => _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HeightSpace(30),
                  OnBuilder<AnswerState>.all(
                    listenTo: answersRM,
                    onWaiting: () => Column(
                      children: List.generate(
                        10,
                        (index) => const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
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
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          child: SkeletonCardPost(
                            isReply: true,
                          ),
                        ),
                      ),
                    ),
                    onError: (dynamic error, refresh) => Text(error.toString()),
                    onData: (data) {
                      return Column(
                        children: [
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
                            animationDuration:
                                const Duration(milliseconds: 800),
                            animationCurve: Curves.fastLinearToSlowEaseIn,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return _buildShowComments(
                                  answersRM.state.allAnswer,
                                );
                              }
                              return _buildCommentForm();
                            },
                          ),
                        ],
                      );
                    },
                  )
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
              OnReactive(
                () => SendAsAnonymSwitcher(
                  isAnonym: answerFormRM.state.isAnonym,
                  onChanged: answerFormRM.state.setIsAnonym,
                ),
              ),
              const HeightSpace(20),
              OnReactive(
                () => ImagePickerBox(
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

  Widget _buildShowComments(List<AnswerModel> data) {
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
                onTap: () async {
                  await _pageController.animateToPage(
                    1, // Index of the second page
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );

                  if (!_isBottom) {
                    await scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                    );
                  }
                },
                isInDetailPage: true,
              ),
            ],
          ),
        ),
        const HeightSpace(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length + 1,
          separatorBuilder: (context, index) => const HeightSpace(16),
          itemBuilder: (context, index) {
            if (index == data.length) {
              return !answersRM.state.hasReachedMax
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: CircleLoading(
                        size: 25,
                      ),
                    )
                  : data.isEmpty
                      ? _buildBottomMax(true)
                      : _buildBottomMax(false);
            }
            final answer = data[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              child: OnBuilder(
                listenTo: answersRM,
                builder: () => CardPost(
                  isReply: true,
                  answerModel: answer,
                  onLikeTap: () {
                    answersRM.state.likeAnswer(answer);
                  },
                  onReplyTap: () => _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                  imageTag: 'reply-image-preview?id=${answer.id}',
                  onRefreshImage: answersRM.notify,
                  onImageTap: () => seeImage(
                      isReply: true,
                      replyId: answer.id.toString(),
                      replyUrlFile: answer.attachmentUrl),
                  optionChoices: const ['Report'],
                  onOptionChoosed: (value) {
                    if (value == 'Report') {
                      print('report reply!');
                      // report reply here
                    }
                  },
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  Widget _buildBottomMax(bool emptyList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: MediaQuery.of(context).size.height  * 7 / 10,
        child: Text(
          emptyList ? 'Belum ada jawaban.' : 'Tidak ada jawaban lagi.',
          style: FontTheme.poppins12w600black().copyWith(
            color: BaseColors.gray2.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      )
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    if (answerFormRM.state.answerController.text != '') {
      final isSucces = await answerFormRM.state.postNewAnswer(widget.model.id);
      if (isSucces) {
        SuccessMessenger('Jawaban berhasil dibuat').show(ctx!);
        // await _pageController.animateToPage(
        //   0, // Index of the second page
        //   duration: const Duration(milliseconds: 1000),
        //   curve: Curves.fastLinearToSlowEaseIn,
        // );
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
    final query = QueryAnswer(questionId: widget.model.id);
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

  bool get _isBottom {
    if (!scrollController.hasClients) {
      if (kDebugMode) print('no client');
      return false;
    }
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    // print(currentScroll >= (maxScroll * 0.95) && _pageController.page == 0);
    return currentScroll >= (maxScroll * 0.95) && _pageController.page == 0;
  }
}
