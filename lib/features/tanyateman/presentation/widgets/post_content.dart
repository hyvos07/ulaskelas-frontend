part of '_widgets.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    this.isInHistorySection = false,
    this.model,
    this.isReply = false,
    this.isDetail = false,
    this.onImageTap,
    super.key,
  });

  final QuestionModel? model;
  final VoidCallback? onImageTap;
  final bool isReply;
  final bool isDetail;
  final bool? isInHistorySection;

  @override
  Widget build(BuildContext context) {
    final maxImageWidth = double.infinity;
    final maxImageHeight =
        MediaQuery.of(context).size.width - (isDetail ? 20 * 2 : 20 * 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            UserProfileBox(
              name: model!.userName,
            ),
            const WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model!.userName,
                          style: FontTheme.poppins12w700black().copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(4),
                  if (!isInHistorySection!)
                    Text(
                      '${model!.userProgram} ${model!.userGeneration}',
                      style: FontTheme.poppins10w400black().copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  else 
                    Text(
                      '${model!.verificationStatus}',
                      style: FontTheme.poppins10w500black().copyWith(
                        color: model!.verificationStatus == 'Menunggu Verifikasi'
                          ? Colors.orange
                          : Colors.green
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
        HeightSpace(isDetail ? 15 : 13.5),
        Text(
          model!.questionText,
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
        if (model!.attachmentUrl != null)
          Column(
            children: [
              HeightSpace(isDetail ? 20 : 18),
              GestureDetector(
                onTap: onImageTap ?? () {},
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return isDetail
                        ? Hero(
                            tag: 'image-preview',
                            child: CachedNetworkImage(
                              imageUrl: model!.attachmentUrl!,
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
                              errorWidget: (context, url, error) => Container(
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
                            
                                return Container(
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
                                );
                              },
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: model!.attachmentUrl!,
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
                            errorWidget: (context, url, error) => Container(
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

                              return Container(
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
                              );
                            },
                          );
                  },
                ),
              ),
              HeightSpace(isDetail ? 20 : 18),
            ],
          )
        else
          HeightSpace(isDetail ? 15 : 13.5),
        if (model!.verificationStatus == 'Terverifikasi')
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/thumbsup.svg',
                height: 24,
                width: 24,
              ),
              const WidthSpace(2),
              Text(
                _shortenEngagement(model!.likeCount),
                style: FontTheme.poppins12w400black().copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
              if (!isReply)
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
                      _shortenEngagement(model!.answers),
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
                model!.exactDateTime,
                style: FontTheme.poppins12w400black().copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          )
        else const SizedBox.shrink()
      ],
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
