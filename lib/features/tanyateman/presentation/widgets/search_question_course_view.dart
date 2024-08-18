part of '_widgets.dart';

class SearchQuestionCourseView extends StatelessWidget {
  const SearchQuestionCourseView({
    required this.refreshIndicatorKey,
    required this.scrollController,
    required this.onScroll,
    required this.onRefresh,
    super.key,
  });

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final ScrollController scrollController;
  final VoidCallback onScroll;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: onRefresh,
            child: OnBuilder<SearchCourseState>.all(
              listenTo: searchCourseRM,
              onIdle: () => ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                children: List.generate(
                  8,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SkeletonCardCourse(),
                  ),
                ),
              ),
              onWaiting: () => ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                children: List.generate(
                  8,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SkeletonCardCourse(),
                  ),
                ),
              ),
              onError: (dynamic error, refresh) {
                final failure = error as Failure;
                return DetailView(
                  title: failure.title ?? 'Error',
                  description: failure.message ?? 'Something error',
                );
              },
              onData: (data) {
                final courses = data.courses;
                if (data.hasReachedMax && courses.isEmpty) {
                  return const DetailView(
                    isEmptyView: true,
                    title: 'Mata Kuliah Tidak Ditemukan',
                    description: '''
Mata kuliah yang kamu cari tidak ada di aplikasi. Silakan coba lagi dengan kata kunci lain.''',
                  );
                }
                return ListView.separated(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  itemCount:
                      data.hasReachedMax ? courses.length : courses.length + 1,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    if (!data.hasReachedMax && i == courses.length) {
                      return const CircleLoading(size: 25);
                    }
                    final course = courses[i];
                    return _buildCardCourse(context, course);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardCourse(BuildContext context, CourseModel model) {
    return GestureDetector(
      onTap: () {
        nav.pop();
        onSubmittingSearch(model);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: BaseColors.white,
          boxShadow: BoxShadowDecorator().defaultShadow(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          model.name.toString(),
          style: FontTheme.poppins12w400black(),
        ),
      ),
    );
  }

  Future<void> onSubmittingSearch(CourseModel model) async {
    final selectedFilter = searchQuestionRM.state.searchQuestionFilter;
    final query = QueryQuestion(
      isHistory: true,
      isMostPopular: selectedFilter == 'is_paling_banyak_disukai' ? true : null,
      isVerified: selectedFilter == 'terverifikasi' ? true : null,
      isWaitToVerify: selectedFilter == 'menunggu_verifikasi' ? true : null,
    );
    await searchQuestionRM.setState((s) => s.retrieveSearchedQuestion(query));
    await searchQuestionRM.setState(
      (s) => s.searchData = SearchData(
        text: '#${model.name}',
        course: model,
      ),
    );
  }
}
