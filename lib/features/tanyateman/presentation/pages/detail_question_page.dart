part of '_pages.dart';

class DetailQuestionPage extends StatefulWidget {
  const DetailQuestionPage({
    required this.model,
    super.key,
  });

  final QuestionModel model;

  @override
  _DetailQuestionPageState createState() => _DetailQuestionPageState();
}

class _DetailQuestionPageState extends BaseStateful<DetailQuestionPage> {
  bool isAnonym = false;
  int pageViewIndex = 0;
  double pageViewHeight = 0;
  late PageController _pageController;
  ImagePicker? _imagePicker;
  File? _fileImage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageViewIndex);
    componentFormRM.setState((s) => s.cleanForm());
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.frequency.text = '1';
    componentFormRM.state.justVisited = true;
    _imagePicker = ImagePicker();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null; // SliverAppBar will be used instead
  }

  Future<void> pickImage() async {
    final pickedImg = await _imagePicker!.pickImage(
      source: ImageSource.gallery,);
    if (pickedImg != null) {
      final fileSizeInBytes = await pickedImg.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      
      if (fileSizeInMB <= 5) {
        final croppedImage = await cropImage(imageFile: File(pickedImg.path));
    
        setState(() {
          _fileImage = croppedImage;
        });
      } else {
        ErrorMessenger('Size of the image is more than 5 MB!').show(context);
      }
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    final croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void seeImage() {

  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: MediaQuery.of(context).size.width,
            leading: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.only(
                    left: 7.5,
                  ),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade900,
                  ),
                  onPressed: onBackPressed,
                ),
                Text(
                    '#${widget.model.tags}',
                    style: FontTheme.poppins12w600black().copyWith(
                      color: Colors.grey.shade600,),
                  ),
              ],
            ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      PostContent(
                        model: widget.model,
                        isDetail: true,
                      ),
                      const HeightSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const QuestionFormLabel(text: 'Komentar'),
                          Row(
                            children: [
                              const FilterIcon(
                                filterOn: true,
                              ),
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
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildShowComments();
                      }
                      return _buildCommentForm();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeightSpace(15),
              const QuestionFormLabel(
                text: 'Pertanyaan',
                bottomPad: 10,
              ),
              const QuestionTextField(),
              const HeightSpace(20),
              const SendAsAnonymSwitcher(),
              const HeightSpace(20),
              ImagePickerBox(
                onTapUpload: pickImage,
                onTapSeeImage: seeImage,
              )
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
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          child: Row(
            children: [
              UserProfileBox(name: profileRM.state.profile.name ?? ''),
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
        const HeightSpace(10),
        Column(
          children: List.generate(16, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              child: CardPost(
                isReply: true,
                model: widget.model,
              ),
            );
          }),
        )
      ]),
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);
    componentFormRM.state.justVisited = false;

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
      if (kDebugMode) {
        print('success');
      }

      return;
    }

    WarningMessenger('Pastikan semua field sudah terisi dengan benar!')
        .show(context);
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
    nav.pop<void>();
    return true;
  }

  @override
  void init() {
    // TODO: implement init
  }
}
