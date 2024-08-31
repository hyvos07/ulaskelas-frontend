part of '_pages.dart';

class TanyaTemanPage extends StatefulWidget {
  const TanyaTemanPage({super.key});

  @override
  _TanyaTemanPageState createState() => _TanyaTemanPageState();
}

class _TanyaTemanPageState extends BaseStateful<TanyaTemanPage> {
  final focusNode = FocusNode();

  Timer? _debounce;

  @override
  void init() {
    searchQuestionRM.setState(
      (s) => s.searchData = SearchData(),
    );
    searchQuestionRM.state.controller.clear();
    questionsRM.state.allQuestionsFilter = 'semua';
    questionsRM.state.historyQuestionsFilter = 'semua';
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((Pref.getBool('doneAppTour') == false ||
              Pref.getBool('doneAppTour') == null) &&
          !backFromCalculator) {
        showcaseTanyaTeman();
      }
    });
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return ShowCaseWidget(
      builder: (context) {
        tanyaTemanContext = context;
        return SafeArea(
          child: Column(
            children: [
              OnReactive(
                () => Padding(
                  padding: EdgeInsets.only(
                    left: searchQuestionRM.state.searchData?.text != null
                        ? 20
                        : 24,
                    right: searchQuestionRM.state.searchData?.text != null
                        ? 22
                        : 24,
                    top: 10,
                    bottom: 3,
                  ),
                  child: Showcase.withWidget(
                    key: inAppTourKeys.searchBarTT,
                    overlayColor: BaseColors.neutral100,
                    overlayOpacity: 0.5,
                    targetPadding: const EdgeInsets.all(8),
                    targetBorderRadius: BorderRadius.circular(10),
                    blurValue: 1,
                    height: 0,
                    width: MediaQuery.of(context).size.width,
                    disposeOnTap: false,
                    disableBarrierInteraction: true,
                    disableMovingAnimation: true,
                    onTargetClick: () {},
                    container: searchBarTTShowcase(context),
                    child: Row(
                      children: [
                        // if (searchQuestionRM.state.searchData?.text != null)
                        //   Row(
                        //     children: [
                        //       IconButton(
                        //         onPressed: () => {
                        //           searchQuestionRM.setState(
                        //             (s) => s.searchData = SearchData(),
                        //           ),
                        //         },
                        //         icon: const Icon(
                        //           Icons.arrow_back_rounded,
                        //           size: 24,
                        //           color: BaseColors.gray2,
                        //         ),
                        //         splashRadius: 20,
                        //         constraints: const BoxConstraints(),
                        //         padding: const EdgeInsets.all(5),
                        //       ),
                        //       const SizedBox(width: 12),
                        //     ],
                        //   ),
                        Expanded(
                          child: OnReactive(
                            () => CustomSearchField(
                              controller: searchQuestionRM.state.controller,
                              focusNode: focusNode,
                              hintText: 'Cari Pertanyaan',
                              onFieldSubmitted: (val) {
                                searchQuestionRM.state.addToHistory(val ?? '');
                              },
                              onQueryChanged: onQueryChanged,
                              onClear: () {
                                // focusNode.unfocus();
                                searchQuestionRM.state.controller.clear();
                                onQueryChanged('');
                                searchQuestionRM.notify();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: OnBuilder<SearchQuestionState>.all(
                  listenTo: searchQuestionRM,
                  shouldRebuild: (t, k) {
                    return searchQuestionRM.state.searchData?.text == null;
                  },
                  onIdle: () => const CircleLoading(),
                  onWaiting: () => const CircleLoading(),
                  onError: (error, refreshError) => Text(error.toString()),
                  onData: (data) {
                    final Widget decidePage;
                    if (searchQuestionRM.state.searchData?.text != null) {
                      decidePage = _buildSearchResult();
                    } else if (searchQuestionRM.state.searchData?.text ==
                        null) {
                      decidePage = _buildNormalResult();
                    } else {
                      decidePage = const SizedBox();
                    }
                    return Stack(
                      children: [
                        decidePage,
                        if (focusNode.hasFocus &&
                            searchQuestionRM.state.controller.text.isEmpty)
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        if (focusNode.hasFocus &&
                            searchQuestionRM.state.controller.text.isEmpty)
                          _buildHistory(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
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

  Future<void> onQueryChanged(String val) async {
    if (val == searchQuestionRM.state.lastQuery) {
      return;
    } else if (val == '') {
      searchQuestionRM.state.lastQuery = val;
      searchQuestionRM.state.searchData = SearchData();
      searchQuestionRM.notify();
      return;
    }

    searchQuestionRM.state.lastQuery = val;
    searchQuestionRM.notify();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    await searchQuestionRM.setState((s) {
      s.hasReachedMax = false;
      return;
    });
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (searchQuestionRM.state.controller.text.isEmpty) {
        searchQuestionRM.state.searchData = SearchData();
        searchQuestionRM.notify();
        return;
      }

      searchQuestionRM.state.addToHistory(
        searchQuestionRM.state.controller.text,
      ); // Save to history after search
      final query = QueryQuestion(
        searchKeyword: searchQuestionRM.state.controller.text,
      );
      await searchQuestionRM.setState(
        (s) => s.retrieveSearchedQuestion(query),
      );
      await searchQuestionRM.setState(
        (s) => s.searchData = SearchData(
          text: searchQuestionRM.state.controller.text,
        ),
      );
    });

    searchQuestionRM.notify();
  }

  Widget _buildHistory() {
    return Container(
      decoration: const BoxDecoration(
        color: BaseColors.transparent,
        backgroundBlendMode: BlendMode.overlay,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Riwayat Pencarian',
                    style: FontTheme.poppins14w700black(),
                  ),
                  InkWell(
                    onTap: () {
                      searchQuestionRM.setState((s) => s.clearHistory());
                      focusNode.unfocus();
                      searchQuestionRM.state.controller.clear();
                      onQueryChanged('');
                    },
                    child: Text(
                      'Hapus',
                      style: FontTheme.poppins12w500black().copyWith(
                        color: BaseColors.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const HeightSpace(10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: searchQuestionRM.state.history.map((element) {
                return InkWell(
                  onTap: () {
                    final controller = searchQuestionRM.state.controller;
                    focusNode.requestFocus();
                    controller
                      ..text = element
                      ..selection = TextSelection.fromPosition(
                        TextPosition(
                          offset: searchQuestionRM.state.controller.text.length,
                        ),
                      );
                    focusNode.unfocus();
                    onQueryChanged(element);
                  },
                  child: Tag(
                    label: element,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    // Every build, reset the filter to 'semua'
    searchQuestionRM.state.searchQuestionFilter = 'semua';
    return const SearchQuestionView();
  }

  Widget _buildNormalResult() {
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(milliseconds: 100),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: BaseColors.gray3,
                      width: 0.3,
                    ),
                  ),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      height: 45,
                      child: Text(
                        'Semua Pertanyaan',
                        style: FontTheme.poppins12w700black(),
                      ),
                    ),
                    Tab(
                      height: 45,
                      child: Text(
                        'Riwayat Pertanyaan',
                        style: FontTheme.poppins12w700black(),
                      ),
                    ),
                  ],
                  // indicator: UnderlineTabIndicator(
                  // borderSide: const BorderSide(
                  //   width: 2.5,
                  //   color: BaseColors.purpleHearth,
                  // ),
                  // insets: const EdgeInsets.symmetric(
                  //   horizontal: 45,
                  // ),
                  // borderRadius: BorderRadius.circular(10),
                  // ),
                  indicator: _UnderlineTab(
                    width: 70,
                    height: 4,
                    color: BaseColors.purpleHearth,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SeeAllQuestion(),
                    HistoryQuestion(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Custom underline tab indicator.
class _UnderlineTab extends Decoration {
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const _UnderlineTab({
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlineTabPainter(width, height, color, borderRadius);
  }
}

class _UnderlineTabPainter extends BoxPainter {
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  _UnderlineTabPainter(this.width, this.height, this.color, this.borderRadius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()..color = color;

    final xOffset = (configuration.size!.width - width) / 2;
    final yOffset = configuration.size!.height - height;

    final rect = Rect.fromLTWH(
      offset.dx + xOffset,
      offset.dy + yOffset,
      width,
      height,
    );

    final rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(rRect, paint);
  }
}
