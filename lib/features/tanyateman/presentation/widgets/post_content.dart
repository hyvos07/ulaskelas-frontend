part of '_widgets.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    this.model,
    this.isReply = false,
    super.key,
  });

  final QuestionModel? model;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
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
        const HeightSpace(12.5),
        Text(
          model!.question,
          style: FontTheme.poppins14w600black().copyWith(
            fontSize: 13,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
        const HeightSpace(12.5),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/thumbsup.svg',
              height: 24,
              width: 24,
            ),
            const WidthSpace(2),
            Text(
              model!.likes.toString(),
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
                  const WidthSpace(5),
                  Text(
                    model!.answers.toString(),
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
}
