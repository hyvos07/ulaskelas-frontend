part of '_widgets.dart';

class SeeAllQuestion extends StatefulWidget {
  const SeeAllQuestion({super.key});

  @override
  _SeeAllQuestionState createState() => _SeeAllQuestionState();
}

class _SeeAllQuestionState extends BaseStateful<SeeAllQuestion> {
  late ScrollController scrollController;
  Completer<void>? completer;

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

    questionsRM.setState((s) => s.retrieveData(QueryQuestion()));
  }

  void _onScroll() {
    if (_isBottom && !completer!.isCompleted && scrollCondition()) {
      print('${scrollCondition()} lol');
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
                        'Semua Pertanyaan',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontWeight: FontWeight.w600,
                          color: BaseColors.gray1,
                        ),
                      ),
                      StateBuilder(
                        observe: () => filterRM,
                        builder: (context, snapshot) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const FilterIcon(filterOn: true),
                              const WidthSpace(5),
                              Text(
                                'Filter',
                                style: FontTheme.poppins12w700black().copyWith(
                                  fontSize: 13,
                                  color: BaseColors.primaryColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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
                                model: question,
                                onTap: () {
                                  nav.goToDetailQuestionPage(question);
                                },
                              );
                            },
                          );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            right: 24,
            bottom: 20,
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
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/ilust_onboard2.png'),
            width: 120,
            height: 120,
          ),
          const WidthSpace(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masih belum menemukan\npertanyaan yang\nkamu cari?',
                style: FontTheme.poppins12w700black(),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
              ),
              const HeightSpace(7),
              Text(
                'Ajukan pertanyaanmu\nsekarang!',
                style: FontTheme.poppins10w500black(),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
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
    await questionsRM.state.retrieveData(QueryQuestion());
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
    print(currentScroll >= (maxScroll * 0.9));
    return currentScroll >= (maxScroll * 0.9);
  }
}