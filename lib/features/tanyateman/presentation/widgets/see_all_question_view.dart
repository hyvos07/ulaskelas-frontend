part of '_widgets.dart';

class SeeAllQuestion extends StatefulWidget {
  const SeeAllQuestion({super.key});

  @override
  _SeeAllQuestionState createState() => _SeeAllQuestionState();
}

class _SeeAllQuestionState extends BaseStateful<SeeAllQuestion> {
  late ScrollController scrollController;
  Completer<void>? completer;

  List<String> filterOptionsValue = [
    'semua',
    'is_paling_banyak_disukai',
  ];

  List<String> filterOptionsText = [
    'Semua',
    'Paling banyak Disukai',
  ];

  @override
  void init() {
    scrollController = ScrollController();
    completer = Completer<void>();
    scrollController.addListener(_onScroll);
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      cacheKey: 'all-question',
      state: false,
    ).initialize();
  }

  void _onScroll() {
    if (_isBottom && !completer!.isCompleted && scrollCondition()) {
      print('${scrollCondition()}');
      onScroll();
    }
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: retrieveData,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Semua Pertanyaan',
                              style: FontTheme.poppins14w700black().copyWith(
                                fontWeight: FontWeight.w600,
                                color: BaseColors.gray1,
                              ),
                            ),
                            OnReactive(_buildFilter),
                          ],
                        ),
                      ),
                      const HeightSpace(15),
                      Showcase.withWidget(
                        key: inAppTourKeys.userBoxTT,
                        overlayColor: BaseColors.neutral100,
                        overlayOpacity: 0.5,
                        targetPadding: const EdgeInsets.all(10),
                        targetBorderRadius: BorderRadius.circular(10),
                        blurValue: 1,
                        height: 0,
                        width: MediaQuery.of(context).size.width,
                        disposeOnTap: false,
                        disableBarrierInteraction: true,
                        disableMovingAnimation: true,
                        onTargetClick: () {},
                        container: userBoxTTShowcase(context),
                        child: Row(
                          children: [
                            UserProfileBox(
                              name:
                                  profileRM.state.profile.name ?? 'Ujang Iman',
                            ),
                            const WidthSpace(10),
                            AskQuestionBox(
                              onTap: () => nav.goToAddQuestionPage(),
                            )
                          ],
                        ),
                      ),
                      const HeightSpace(25),
                      OnBuilder<QuestionState>.all(
                        listenTo: questionsRM,
                        onWaiting: () => Column(
                          children: List.generate(
                            10,
                            (index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: SkeletonCardPost(
                                isReply: false,
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
                                isReply: false,
                              ),
                            ),
                          ),
                        ),
                        onError: (error, refresh) => Text(error.toString()),
                        onData: (data) {
                          return data.allQuestions.isEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Text(
                                    'Tidak ada apa-apa disini.',
                                    style:
                                        FontTheme.poppins12w600black().copyWith(
                                      color: BaseColors.gray2.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.allQuestions.length + 1,
                                  separatorBuilder: (context, index) =>
                                      const HeightSpace(16),
                                  itemBuilder: (context, index) {
                                    if (index == data.allQuestions.length) {
                                      return !data.hasReachedMax
                                          ? const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              child: CircleLoading(
                                                size: 25,
                                              ),
                                            )
                                          : _buildBottomMax();
                                    }
                                    final question = data.allQuestions[index];
                                    return CardPost(
                                      questionModel: question,
                                      imageTag: 'post-image-preview'
                                          '?id=${question.id}',
                                      onTap: () {
                                        nav.goToDetailQuestionPage(question);
                                      },
                                      onLikeTap: () => questionsRM.state
                                          .likeQuestion(question),
                                      onReplyTap: () {
                                        print('tap');
                                        nav.goToDetailQuestionPage(
                                          question,
                                          toReply: true,
                                        );
                                      },
                                      onRefreshImage: questionsRM.notify,
                                      optionChoices: const ['Hapus'],
                                      onOptionChoosed: (value) {
                                        if (value == 'Hapus') {
                                          // TODO
                                        }
                                      },
                                    );
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 18,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: BaseColors.purpleHearth,
                  foregroundColor: BaseColors.white,
                  mini: true,
                  onPressed: _scrollToTop,
                  child: const Icon(
                    Icons.expand_less_rounded,
                    size: 25,
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
    return true;
  }

  Widget _buildBottomMax() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        'Tidak ada pertanyaan lagi.',
        style: FontTheme.poppins12w600black().copyWith(
          color: BaseColors.gray2.withOpacity(0.7),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFilter() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FilterIcon(
              filterOn: questionsRM.state.allQuestionsFilter != 'semua',
            ),
            const WidthSpace(5),
            Text(
              'Filter',
              style: FontTheme.poppins12w700black().copyWith(
                fontSize: 13,
                color: BaseColors.primaryColor,
              ),
            ),
          ],
        ),
        items: List.generate(
          filterOptionsValue.length,
          (index) => DropdownMenuItem(
            alignment: Alignment.center,
            value: filterOptionsValue[index],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: questionsRM.state.allQuestionsFilter ==
                        filterOptionsValue[index]
                    ? BaseColors.gray5
                    : BaseColors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      filterOptionsText[index],
                      style: FontTheme.poppins12w400black().copyWith(),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onChanged: (value) {
          questionsRM.setState(
            (s) => s.allQuestionsFilter = value.toString(),
          );
          retrieveData();
          if (kDebugMode) print('filter: $value');
        },
        dropdownStyleData: DropdownStyleData(
          width: 140,
          direction: DropdownDirection.left,
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: BaseColors.white,
          ),
          elevation: 1,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 45,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Future<void> onScroll() async {
    completer?.complete();
    final query = QueryQuestion(
      isMostPopular:
          questionsRM.state.allQuestionsFilter == 'is_paling_banyak_disukai'
              ? true
              : null,
    );
    await questionsRM.state.retrieveMoreAllQuestion(query).then((value) {
      completer = Completer<void>();
      questionsRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  Future<void> retrieveData() async {
    await questionsRM.setState(
      (s) => s.retrieveAllQuestion(
        QueryQuestion(
          isMostPopular:
              questionsRM.state.allQuestionsFilter == 'is_paling_banyak_disukai'
                  ? true
                  : null,
        ),
      ),
    );
  }

  bool scrollCondition() {
    return !questionsRM.state.hasReachedMax;
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
