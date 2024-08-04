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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: PrimaryButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  width: double.infinity,
                  text: 'Add New Question Page',
                  backgroundColor: BaseColors.purpleHearth,
                  onPressed: () => {
                    nav.goToAddQuestionPage()
                  },
                ),
              ),
              const HeightSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: PrimaryButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  width: double.infinity,
                  text: 'Question Detail Page',
                  backgroundColor: BaseColors.bronze2,
                  onPressed: () => {
                    nav.goToDetailQuestionPage()
                  },
                ),
              ),
              const HeightSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: PrimaryButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  width: double.infinity,
                  text: 'Forum TanyaTeman',
                  backgroundColor: BaseColors.blue2,
                  onPressed: () => {
                    nav.goToForumTanyaTeman()
                  },
                ),
              ),
            ],
          ),
        ),
      )
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
