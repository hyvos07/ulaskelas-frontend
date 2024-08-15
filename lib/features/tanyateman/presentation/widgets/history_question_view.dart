part of '_widgets.dart';

class HistoryQuestion extends StatefulWidget {
  const HistoryQuestion({super.key});

  @override
  _HistoryQuestionState createState() => _HistoryQuestionState();
}

class _HistoryQuestionState extends BaseStateful<HistoryQuestion> {
  late ScrollController scrollController;
  Completer<void>? completer;

  List<String> filterOptionsValue = [
    'semua',
    'terbaru',
    'is_paling_banyak_disukai',
    'terverifikasi',
    'menunggu_verifikasi'
  ];

  List<String> filterOptionsText = [
    'Semua',
    'Terbaru',
    'Paling banyak Disukai',
    'Terverifikasi',
    'Menunggu Verifikasi'
  ];

  @override
  void init() {
    scrollController = ScrollController();
    completer = Completer<void>();
    scrollController.addListener(_onScroll);
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      cacheKey: 'history-question',
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
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seluruh Postingan Kamu!',
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
                  onError: (dynamic error, refresh) => Text(error.toString()),
                  onData: (data) {
                    return data.questions.isEmpty
                        ? Center(
                            // TODO: Change this
                            child: Text(
                              'Belum ada pertanyaan nih',
                              style: FontTheme.poppins14w400black(),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.questions.length + 1,
                            separatorBuilder: (context, index) =>
                                const HeightSpace(16),
                            itemBuilder: (context, index) {
                              if (index == data.questions.length) {
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
                              final question = data.questions[index];
                              return CardPost(
                                isInHistorySection: true,
                                model: question,
                                // onTap: () {
                                //   nav.goToDetailQuestionPage(question);
                                // },
                              );
                            },
                          );
                  },
                ),
              ],
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
        ));
  }

  Widget _buildFilter() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FilterIcon(
              filterOn: questionsRM.state.historyQuestionsFilter != 'semua',
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
            alignment: Alignment.topCenter,
            value: filterOptionsValue[index],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: questionsRM.state.historyQuestionsFilter ==
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
            (s) => s.historyQuestionsFilter = value.toString(),
          );
          retrieveData();
          if (kDebugMode) print('filter: $value');
        },
        dropdownStyleData: DropdownStyleData(
          width: 140,
          direction: DropdownDirection.left,
          padding: const EdgeInsets.symmetric(vertical: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: BaseColors.white,
          ),
          elevation: 1,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 42,
          padding: EdgeInsets.symmetric(horizontal: 14),
        ),
      ),
    );
  }

  Future<void> onScroll() async {
    completer?.complete();
    final query = QueryQuestion();
    await questionsRM.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      questionsRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  Future<void> retrieveData() async {
    final selectedFilter = questionsRM.state.historyQuestionsFilter;
    final query = QueryQuestion(
      isHistory: true,
      isMostPopular: selectedFilter == 'is_paling_banyak_disukai'
        ? true : null,
      isVerified: selectedFilter == 'terverifikasi'
        ? true : null,
      isWaitToVerify:  selectedFilter == 'menunggu_verifikasi'
        ? true : null
    );
    await questionsRM.setState((s) => s.retrieveData(query));
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
