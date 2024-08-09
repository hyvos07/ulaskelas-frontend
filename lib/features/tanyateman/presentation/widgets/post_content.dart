part of '_widgets.dart';

class PostContent extends StatelessWidget {
  const PostContent({
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

  @override
  Widget build(BuildContext context) {
    final maxImageWidth = double.infinity;
    final maxImageHeight = MediaQuery.of(context).size.width - (20 * 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            UserProfileBox(
              name: model!.userFullName,
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
                            text: model!.userFullName,
                            style: FontTheme.poppins12w700black().copyWith(
                              height: 1.75,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              const WidgetSpan(
                                child: WidthSpace(8),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  model!.relativeDateTime,
                                  style:
                                      FontTheme.poppins12w400black().copyWith(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(4),
                  Text(
                    '${model!.userMajor} ${model!.userGeneration}',
                    style: FontTheme.poppins10w400black().copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        HeightSpace(isDetail ? 15 : 13.5),
        Text(
          model!.question,
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
                    return CachedNetworkImage(
                      imageUrl: model!.attachmentUrl!,
                      placeholder: (context, url) => SizedBox(
                        height: MediaQuery.of(context).size.width - (20 * 4),
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
                        height: MediaQuery.of(context).size.width - (20 * 4),
                        decoration: BoxDecoration(
                          color: BaseColors.gray3,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error,
                                color: BaseColors.gray1,
                              ),
                              const HeightSpace(10),
                              Text(
                                'Gagal memuat gambar',
                                style: FontTheme.poppins12w400black().copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
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
                            displayHeight = isDetail
                                ? displayWidth / aspectRatio
                                : displayWidth / aspectRatio > maxImageHeight
                                    ? maxImageHeight
                                    : displayWidth / aspectRatio;
                          }),
                        );

                        return Container(
                          width: maxImageWidth,
                          height: displayHeight,
                          decoration: BoxDecoration(
                            color: BaseColors.gray4.withOpacity(0.6),
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
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/thumbsup.svg',
              height: 24,
              width: 24,
            ),
            const WidthSpace(2),
            Text(
              _shortenEngagement(model!.likes),
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
