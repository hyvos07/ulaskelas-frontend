part of '_widgets.dart';

class SeeAllQuestion extends StatefulWidget {
  const SeeAllQuestion({super.key});

  @override
  _SeeAllQuestionState createState() => _SeeAllQuestionState();
}

class _SeeAllQuestionState
    extends BasePaginationState<SeeAllQuestion, AllQuestionState> {
  final focusNode = FocusNode();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
    ReactiveModel<AllQuestionState> snapshot,
    SizingInformation sizeInfo,
  ) {
    final userShortName =
        _getShortName(profileRM.state.profile.name ?? 'Ujang Iman'); // UI

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: [
          Row(
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
                  return FilterButton(
                    hasFilter: filterRM.state.hasFilter,
                    text: 'Filter',
                    onPressed: () async {
                      await nav.goToFilterPage();

                      if (filterRM.state.hasFilter) {
                        await refreshIndicatorKey.currentState?.show();
                      }
                    },
                  );
                },
              ),
            ],
          ),
          const HeightSpace(15),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: BaseColors.primary.withOpacity(.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    userShortName ?? 'UI',
                    style: FontTheme.poppins14w700black().copyWith(
                      color: BaseColors.primary,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const WidthSpace(10),
              AskQuestionBox(
                onTap: () => nav.goToAddQuestionPage(),
              )
            ],
          ),
          const HeightSpace(20),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const HeightSpace(10),
              itemBuilder: (context, index) {
                return CardPost(
                  onTap: () {
                    nav.goToDetailQuestionPage();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildWideLayout(BuildContext context,
      ReactiveModel<AllQuestionState> k, SizingInformation sizeInfo) {
    return buildNarrowLayout(context, k, sizeInfo);
  }

  @override
  void init() {}

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  @override
  void onScroll() {
    completer?.complete();
    // TODO: Implement yh
  }

  @override
  Future<void> retrieveData() async {
    // TODO: implement retrieveData
  }

  @override
  bool scrollCondition() {
    return false;
  }

  String? _getShortName(String name) {
    String shortName;

    shortName = name.split(' ').fold<String>(
          '',
          (previousValue, element) =>
              previousValue + element.substring(0, min(element.length, 1)),
        );
    shortName = shortName.substring(0, min(shortName.length, 2));

    return shortName;
  }
}
