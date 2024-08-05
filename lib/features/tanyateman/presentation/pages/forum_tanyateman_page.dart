part of '_pages.dart';

class ForumTanyaTemanPage extends StatefulWidget {
  const ForumTanyaTemanPage({super.key});

  @override
  _ForumTanyaTemanState createState() => _ForumTanyaTemanState();
}

class _ForumTanyaTemanState extends BaseStateful<ForumTanyaTemanPage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'TanyaTeman',
      onBackPress: onBackPressed,
      elevation: 1,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: DefaultTabController(
          length: 2,
          animationDuration: const Duration(milliseconds: 100),
          child: Builder(
            builder: (context) {
              final tabController = DefaultTabController.of(context);
              tabController.addListener(() {
                if (!tabController.indexIsChanging) {
                  // Nanti retrieve data setiap tab diganti
                } // NOTE: maybe nanti (else) waktu changingindex bwt clear data
              });
              return Column(
                children: [
                  TabBar(
                    indicatorPadding: const EdgeInsets.only(bottom: 5),
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Tab(
                        child: Text(
                          'Semua Pertanyaan',
                          style: FontTheme.poppins12w700black(),
                        ),
                      ),
                      Tab(
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
        ),
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
    nav.pop();
    return true;
  }
}

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
