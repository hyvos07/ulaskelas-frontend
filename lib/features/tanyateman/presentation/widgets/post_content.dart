part of '_widgets.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    this.isInHistorySection = false,
    this.questionModel,
    this.answerModel,
    this.imageTag,
    this.isReply = false,
    this.isDetail = false,
    this.onImageTap,
    this.onRefreshImage,
    super.key,
  });

  final QuestionModel? questionModel;
  final AnswerModel? answerModel;
  final String? imageTag;
  final VoidCallback? onImageTap;
  final VoidCallback? onRefreshImage;
  final bool isReply;
  final bool isDetail;
  final bool? isInHistorySection;

  @override
  Widget build(BuildContext context) {
    final maxImageWidth = double.infinity;
    final maxImageHeight =
        MediaQuery.of(context).size.width - (isDetail ? 20 * 2 : 20 * 4);

    // Detect if the user is the one who posted the question
    final isUserThemself = questionModel != null
        ? questionModel!.userName == profileRM.state.profile.name
        : answerModel!.userName == profileRM.state.profile.name;
    ;

    return Container(
      decoration: const BoxDecoration(
        color: BaseColors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              UserProfileBox(
                name: questionModel != null
                    ? questionModel!.isAnonym && !isUserThemself
                        ? 'Anon Nimus'
                        : questionModel!.userName
                    : answerModel!.isAnonym && !isUserThemself
                        ? 'Anon Nimus'
                        : answerModel!.userName,
              ),
              const WidthSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: questionModel != null
                                      ? questionModel!.isAnonym &&
                                              !isUserThemself
                                          ? 'Anonymous'
                                          : questionModel!.userName
                                      : answerModel!.isAnonym && !isUserThemself
                                          ? 'Anonymous'
                                          : answerModel!.userName,
                                  style:
                                      FontTheme.poppins12w700black().copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.5,
                                  ),
                                ),
                                if (questionModel != null
                                    ? questionModel!.isAnonym && isUserThemself
                                    : answerModel!.isAnonym && isUserThemself)
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 6,
                                      ),
                                      child: SvgPicture.asset(
                                        SvgIcons.incognito,
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                          BaseColors.gray2,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            style: FontTheme.poppins12w700black().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    const HeightSpace(4),
                    if (!isInHistorySection!)
                      Text(
                        questionModel != null
                            ? questionModel!.isAnonym && !isUserThemself
                                ? 'Mahasiswa UI'
                                : '${questionModel!.userProgram} ${questionModel!.userGeneration}'
                            : answerModel!.isAnonym && !isUserThemself
                                ? 'Mahasiswa UI'
                                : '${answerModel!.userProgram} ${answerModel!.userGeneration}',
                        style: FontTheme.poppins10w400black().copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    else if (questionModel != null)
                      Text(
                        '${questionModel!.verificationStatus}',
                        style: FontTheme.poppins10w500black().copyWith(
                            color: questionModel!.verificationStatus ==
                                    'Menunggu Verifikasi'
                                ? Colors.orange
                                : Colors.green),
                      )
                  ],
                ),
              ),
            ],
          ),
          HeightSpace(isDetail ? 15 : 13.5),
          Text(
            questionModel != null
                ? questionModel!.questionText
                : answerModel!.answerText,
            style: isDetail || isReply
                ? FontTheme.poppins14w500black().copyWith(
                    fontSize: 13,
                    height: 1.75,
                  )
                : FontTheme.poppins14w600black().copyWith(
                    fontSize: 13,
                    height: 1.7,
                  ),
            maxLines: isDetail ? null : 3,
            overflow: isDetail ? TextOverflow.visible : TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          if (questionModel != null
              ? questionModel!.attachmentUrl != null
              : answerModel!.attachmentUrl != null)
            Column(
              children: [
                HeightSpace(isDetail ? 20 : 18),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return isDetail || isInHistorySection! || isReply
                        ? Hero(
                            tag: '$imageTag',
                            createRectTween: (begin, end) {
                              return RectTween(
                                begin: begin,
                                end: end,
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: questionModel != null
                                  ? questionModel!.attachmentUrl!
                                  : answerModel!.attachmentUrl!,
                              placeholder: (context, url) => SizedBox(
                                height: maxImageHeight,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: BaseColors.gray3,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  GestureDetector(
                                onTap: onRefreshImage,
                                child: Container(
                                  height: maxImageHeight,
                                  decoration: BoxDecoration(
                                    color: BaseColors.gray3,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.warning_rounded,
                                          color: BaseColors.gray1,
                                          size: 40,
                                        ),
                                        const HeightSpace(10),
                                        Text(
                                          'Gagal memuat gambar!'
                                          '\nHarap refresh ulang.',
                                          style: FontTheme.poppins12w600black(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              imageBuilder: (context, imageProvider) {
                                double? displayHeight;
                                imageProvider
                                    .resolve(ImageConfiguration.empty)
                                    .addListener(
                                  ImageStreamListener((ImageInfo info, bool _) {
                                    final aspectRatio =
                                        info.image.width / info.image.height;
                                    final displayWidth =
                                        constraints.maxWidth < maxImageWidth
                                            ? constraints.maxWidth
                                            : maxImageWidth;
                                    displayHeight = displayWidth / aspectRatio >
                                            maxImageHeight
                                        ? maxImageHeight
                                        : displayWidth / aspectRatio;
                                  }),
                                );

                                return GestureDetector(
                                  onTap: onImageTap ?? () {},
                                  child: Container(
                                    width: maxImageWidth,
                                    height: displayHeight,
                                    decoration: BoxDecoration(
                                      color: BaseColors.gray4.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        color: BaseColors.gray1,
                                        width: 0.1,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: questionModel != null
                                ? questionModel!.attachmentUrl!
                                : answerModel!.attachmentUrl!,
                            placeholder: (context, url) => SizedBox(
                              height: maxImageHeight,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: BaseColors.gray3,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                GestureDetector(
                              // TODO: gimana cara nge refresh image nya
                              onTap: onRefreshImage,
                              child: Container(
                                height: maxImageHeight,
                                decoration: BoxDecoration(
                                  color: BaseColors.gray3,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.warning_rounded,
                                        color: BaseColors.gray1,
                                        size: 40,
                                      ),
                                      const HeightSpace(10),
                                      Text(
                                        'Gagal memuat gambar!'
                                        '\nKlik untuk mencoba lagi.',
                                        style: FontTheme.poppins12w600black(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            imageBuilder: (context, imageProvider) {
                              double? displayHeight;
                              imageProvider
                                  .resolve(ImageConfiguration.empty)
                                  .addListener(
                                ImageStreamListener((ImageInfo info, bool _) {
                                  final aspectRatio =
                                      info.image.width / info.image.height;
                                  final displayWidth =
                                      constraints.maxWidth < maxImageWidth
                                          ? constraints.maxWidth
                                          : maxImageWidth;
                                  displayHeight = displayWidth / aspectRatio >
                                          maxImageHeight
                                      ? maxImageHeight
                                      : displayWidth / aspectRatio;
                                }),
                              );

                              return GestureDetector(
                                onTap: onImageTap ?? () {},
                                child: Container(
                                  width: maxImageWidth,
                                  height: displayHeight,
                                  decoration: BoxDecoration(
                                    color: BaseColors.gray4.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      alignment: Alignment.topCenter,
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: BaseColors.gray1,
                                      width: 0.1,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
                HeightSpace(isDetail ? 20 : 18),
              ],
            )
          else
            HeightSpace(isDetail ? 15 : 13.5),
          if (questionModel != null &&
              questionModel!.verificationStatus == 'Menunggu Verifikasi' &&
              isInHistorySection!)
            const SizedBox.shrink()
          else
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/thumbsup.svg',
                  height: 24,
                  width: 24,
                ),
                const WidthSpace(2),
                Text(
                  _shortenEngagement(questionModel != null
                      ? questionModel!.likeCount
                      : answerModel!.likeCount),
                  style: FontTheme.poppins12w400black().copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                if (!isReply && questionModel != null)
                  Row(
                    children: [
                      const WidthSpace(10),
                      SvgPicture.asset(
                        'assets/icons/comment.svg',
                        height: 16,
                        width: 16,
                      ),
                      const WidthSpace(6),
                      Text(
                        _shortenEngagement(questionModel!.replyCount),
                        style: FontTheme.poppins12w400black().copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                const WidthSpace(10),
                Text(
                  '|',
                  style: FontTheme.poppins14w400black().copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const WidthSpace(10),
                Text(
                  questionModel != null
                      ? questionModel!.exactDateTime
                      : answerModel!.exactDateTime,
                  style: FontTheme.poppins12w400black().copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            )
        ],
      ),
    );
  }

  String _shortenEngagement(int entity) {
    if (entity >= 1000000) {
      return '${(entity / 1000000).toStringAsFixed(1)}M';
    } else if (entity >= 1000) {
      return '${(entity / 1000).toStringAsFixed(1)}k';
    }
    return entity.toString();
  }
}
