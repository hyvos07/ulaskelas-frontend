part of '_pages.dart';

class TanyaTemanPage extends StatefulWidget {
  const TanyaTemanPage({super.key});

  @override
  _TanyaTemanPageState createState() => _TanyaTemanPageState();
}

class _TanyaTemanPageState extends BaseStateful<TanyaTemanPage> {
  @override
  void init() {
    searchQuestionRM.setState(
      (s) => s.searchData = SearchData(),
    );
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
                        ? 22
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
                        if (searchQuestionRM.state.searchData?.text != null)
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => {
                                  searchQuestionRM.setState(
                                    (s) => s.searchData = SearchData(),
                                  ),
                                },
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  size: 24,
                                  color: BaseColors.gray2,
                                ),
                                splashRadius: 20,
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.all(5),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => {
                              nav.goToSearchQuestionPage(),
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: BaseColors.gray3,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    size: 20,
                                    color: BaseColors.gray3,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      searchQuestionRM.state.searchData?.text ??
                                          'Cari Matkul atau Pertanyaan',
                                      style: FontTheme.poppins12w500black()
                                          .copyWith(
                                        color: BaseColors.gray3,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
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
                  onIdle: () => const CircleLoading(),
                  onWaiting: () => const CircleLoading(),
                  onError: (error, refreshError) => Text(error.toString()),
                  onData: (data) {
                    if (searchQuestionRM.state.searchData?.text != null) {
                      return _buildSearchResult();
                    }
                    return _buildNormalResult();
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

  Widget _buildSearchResult() {
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
