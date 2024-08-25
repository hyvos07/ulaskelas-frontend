part of '_widgets.dart';

class SearchQuestionView extends StatefulWidget {
  const SearchQuestionView({super.key});

  @override
  _SearchQuestionViewState createState() => _SearchQuestionViewState();
}

class _SearchQuestionViewState extends BaseStateful<SearchQuestionView> {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final searchQuery = searchQuestionRM.state.searchData?.text;
        return Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
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
                          Expanded(
                            child: Text(
                              searchQuery != null
                                  ? searchQuery.startsWith('#')
                                      ? searchQuery
                                      : 'Hasil Pencarian: $searchQuery'
                                  : 'Hasil Pencarian',
                              style: FontTheme.poppins14w700black().copyWith(
                                fontWeight: FontWeight.w600,
                                color: BaseColors.gray1,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const WidthSpace(25),
                          OnReactive(_buildFilter),
                        ],
                      ),
                    ),
                    const HeightSpace(15),
                    Row(
                      children: [
                        UserProfileBox(
                          name: profileRM.state.profile.name ?? 'Ujang Iman',
                        ),
                        const WidthSpace(10),
                        AskQuestionBox(
                          onTap: () => nav.goToAddQuestionPage(),
                        )
                      ],
                    ),
                    const HeightSpace(25),
                    OnBuilder<SearchQuestionState>.all(
                      listenTo: searchQuestionRM,
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
                      onError: (dynamic error, refresh) =>
                          Text(error.toString()),
                      onData: (data) {
                        return data.searchedQuestions.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(15),
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      HeightSpace(
                                        sizeInfo.screenSize.height * .05,
                                      ),
                                      Image.asset(
                                        Ilustration.notfound,
                                        width: sizeInfo.screenSize.width * .6,
                                      ),
                                      const HeightSpace(27),
                                      Text(
                                        'Pertanyaan Tidak Ditemukan',
                                        style: FontTheme.poppins14w700black()
                                            .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      const HeightSpace(7),
                                      Text(
                                        'Pertanyaan yang kamu cari tidak '
                                        'ditemukan. Silakan coba lagi dengan '
                                        'cara lainnya atau ajukan '
                                        'langsung pertanyaanmu.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.searchedQuestions.length + 1,
                                separatorBuilder: (context, index) =>
                                    const HeightSpace(16),
                                itemBuilder: (context, index) {
                                  if (index == data.searchedQuestions.length) {
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
                                  final question =
                                      data.searchedQuestions[index];
                                  return CardPost(
                                    questionModel: question,
                                    onTap: () {
                                      nav.goToDetailQuestionPage(question);
                                    },
                                    onRefreshImage: questionsRM.notify,
                                    optionChoices: const ['Report'],
                                    onOptionChoosed: (value) {
                                      if (value == 'Report') {
                                        print('report question!');
                                        // report question here
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
              filterOn: searchQuestionRM.state.searchQuestionFilter != 'semua',
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
                color: searchQuestionRM.state.searchQuestionFilter ==
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
          searchQuestionRM.setState(
            (s) => s.searchQuestionFilter = value.toString(),
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
    final selectedFilter = searchQuestionRM.state.searchQuestionFilter;
    final query = QueryQuestion(
      isHistory: true,
      isMostPopular: selectedFilter == 'is_paling_banyak_disukai' ? true : null,
    );
    await searchQuestionRM.state
        .retrieveMoreSearchedQuestion(query)
        .then((value) {
      completer = Completer<void>();
      questionsRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  Future<void> retrieveData() async {
    final selectedFilter = searchQuestionRM.state.searchQuestionFilter;
    final searchData = searchQuestionRM.state.searchData;
    final query = QueryQuestion(
      searchKeyword: searchData?.course == null ? searchData?.text : null,
      searchCourseId: searchData?.course?.id,
      isMostPopular: selectedFilter == 'is_paling_banyak_disukai' ? true : null,
    );
    await searchQuestionRM.setState(
      (s) => s.retrieveSearchedQuestion(query),
    );
    await searchQuestionRM.setState((s) => s.retrieveSearchedQuestion(query));
  }

  bool scrollCondition() {
    return !searchQuestionRM.state.hasReachedMax;
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
