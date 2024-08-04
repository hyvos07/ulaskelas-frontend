part of '_pages.dart';

class DetailQuestionPage extends StatefulWidget {
  const DetailQuestionPage({
    super.key,
  });

  @override
  _DetailQuestionPageState createState() => _DetailQuestionPageState();
}

class _DetailQuestionPageState extends BaseStateful<DetailQuestionPage> {
  bool isAnonym = false;
  int pageViewIndex = 0;
  double pageViewHeight = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageViewIndex);
    componentFormRM.setState((s) => s.cleanForm());
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.frequency.text = '1';
    componentFormRM.state.justVisited = true;
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null; // SliverAppBar will be used instead
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey.shade900,
            ),
            onPressed: () => onBackPressed(),
          ),
          title: Text(
            '#Struktur Data dan Algoritma',
            style: FontTheme.poppins14w400black()
                .copyWith(color: Colors.grey.shade700),
          ),
          centerTitle: false,
          actions: [
            Icon(
              Icons.more_horiz,
              color: Colors.grey.shade900,
            ),
            const WidthSpace(20),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    const PostContent(),
                    const HeightSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const QuestionFormLabel(text: 'Komentar'),
                        Row(
                          children: [
                            const FilterIcon(),
                            QuestionFormLabel(
                              text: 'Filter',
                              color: BaseColors.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const HeightSpace(20),
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
                animationDuration: const Duration(milliseconds: 500),
                itemCount: 2, 
                itemBuilder: (context,index) {
                  if (index == 0) {
                    return _buildShowComments();
                  }
                  return _buildCommentForm();
                }
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentForm() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionFormLabel(
                text: 'Pertanyaan',
                bottomPad: 10,
              ),
              const QuestionTextField(),
              const HeightSpace(20),
              const SendAsAnonymSwitcher(),
              const HeightSpace(20),
              ImagePickerBox(
                onTap: () {
                
              })
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

  Widget _buildShowComments() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20
            ),
            child: Row(
              children: [
                const UserProfileBox(name: 'Rafie Asadel Tarigan'),
                const WidthSpace(10),
                AskQuestionBox(
                  onTap: () => _pageController.animateToPage(
                    1, // Index of the second page
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: List.generate(16, (index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: CardPost(
                  isReply: true,
                ),
              );
            }),
          )
        ]
      ),
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);
    componentFormRM.state.justVisited = false;
    componentFormRM.state.emptyScoreDetect();

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }
    MixpanelService.track('calculator_add_course_component');
    if (componentFormRM.state.formKey.currentState!.validate() &&
        !componentFormRM.state.scoreControllers
            .any((element) => element.text.isEmpty)) {
      await componentFormRM.state.submitForm(1);
      await Future.delayed(const Duration(milliseconds: 150));

      nav.pop();

      final averageScore = componentFormRM.state.averageScore();
      final weight = componentFormRM.state.formData.weight!;

      componentFormRM.state.cleanForm();
      componentFormRM.state.emptyScoreDetect();
      if (kDebugMode) {
        print('success');
      }

      return;
    }

    WarningMessenger('Pastikan semua field sudah terisi dengan benar!')
        .show(context);
    componentFormRM.state.emptyScoreDetect();
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
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.cleanForm();
    componentFormRM.state.emptyScoreDetect();
    nav.pop<void>();
    return true;
  }

  @override
  void init() {
    // TODO: implement init
  }
}
