part of '_pages.dart';

class TanyaTemanPage extends StatefulWidget {
  const TanyaTemanPage({
    super.key,
  });

  @override
  _TanyaTemanPageState createState() => _TanyaTemanPageState();
}

class _TanyaTemanPageState extends BaseStateful<TanyaTemanPage> {
  final userGen = int.parse(profileRM.state.profile.generation!);

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: semesterRM.state.getCondition(),
      cacheKey: semesterRM.state.cacheKey!,
    ).initialize();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      hasLeading: false,
      label: 'Tanya Teman',
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: Container()
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

  void onScroll() {}

  Future<void> retrieveData() async {
    await semesterRM.setState((s) => s.retrieveData());
    if (semesterRM.state.autoFillSemesters.isEmpty) {
      await semesterRM.setState((s) => s.retrieveDataForAutoFillSemesters());
    }
  }

  bool scrollCondition() {
    throw UnimplementedError();
  }
}
