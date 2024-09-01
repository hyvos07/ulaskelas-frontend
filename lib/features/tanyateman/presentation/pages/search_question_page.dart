part of '_pages.dart';

class SearchQuestionPage extends StatefulWidget {
  const SearchQuestionPage({
    required this.filterTarget,
    super.key,
  });

  final int filterTarget;

  @override
  _SearchQuestionPageState createState() => _SearchQuestionPageState();
}

class _SearchQuestionPageState
    extends BasePaginationState<SearchQuestionPage, SearchCourseState> {
  final focusNode = FocusNode();

  Timer? _debounce;

  @override
  void init() {
    focusNode.addListener(() {
      final controller = searchCourseRM.state.controller;
      if (controller.text.isNotEmpty && !focusNode.hasFocus) {
        searchCourseRM.setState((s) => s.addToHistory(controller.text));
      }
    });
    searchCourseRM.state.controller.clear();
    retrieveData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void onScroll() {
    completer?.complete();
    final query = QuerySearchCourse(
      name: searchCourseRM.state.controller.text,
    );
    searchCourseRM.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      searchCourseRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  @override
  Future<void> retrieveData() async {
    await searchCourseRM.setState(
      (s) => s.retrieveData(
        QuerySearchCourse(
          name: searchCourseRM.state.controller.text,
        ),
      ),
    );
  }

  @override
  bool scrollCondition() {
    return !searchCourseRM.state.hasReachedMax;
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Filter Berdasarkan Mata Kuliah',
      onBackPress: onBackPressed,
      elevation: 0.5,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    ReactiveModel<SearchCourseState> k,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Pilih Postingan Mata Kuliah yang kamu cari!',
                    style: FontTheme.poppins12w600black(),
                  ),
                ),
                OnReactive(
                  () => SearchField(
                    hintText: 'Cari Matkul atau Postingan',
                    focusNode: focusNode,
                    controller: searchCourseRM.state.controller,
                    onClear: () {
                      focusNode.unfocus();
                      searchCourseRM.state.controller.clear();
                      onQueryChanged('');
                      searchCourseRM.notify();
                    },
                    onFieldSubmitted: (val) {
                      searchCourseRM.state.addToHistory(val);
                    },
                    onChange: onQueryChanged,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: OnReactive(
              () {
                if (focusNode.hasFocus &&
                    searchCourseRM.state.controller.text.isEmpty) {
                  return _buildHistory();
                } else {
                  return SearchQuestionCourseView(
                    refreshIndicatorKey: refreshIndicatorKey,
                    scrollController: scrollController,
                    onScroll: onScroll,
                    onRefresh: retrieveData,
                    filterTarget: widget.filterTarget,
                  );
                }
              },
            ),
          ),
          // OnReactive(_buildButton),
        ],
      ),
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    ReactiveModel<SearchCourseState> k,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, k, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    focusNode.unfocus();
    nav.pop();
    return true;
  }

  Future<void> onQueryChanged(String val) async {
    if (val == searchCourseRM.state.lastQuery) {
      return;
    }
    searchCourseRM.state.lastQuery = val;
    searchCourseRM.notify();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    await searchCourseRM.setState((s) {
      s.hasReachedMax = false;
      return;
    });
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final query = QuerySearchCourse(name: val);
      searchCourseRM.state
          .searchMatkul(query)
          .then((value) => searchCourseRM.notify());
    });
  }

  Widget _buildHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
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
                    searchCourseRM.setState((s) => s.clearHistory());
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
            children: searchCourseRM.state.history.map((element) {
              return InkWell(
                onTap: () {
                  final controller = searchCourseRM.state.controller;
                  focusNode.requestFocus();
                  controller
                    ..text = element
                    ..selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: searchCourseRM.state.controller.text.length,
                      ),
                    );
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
    );
  }
}
