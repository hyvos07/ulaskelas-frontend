part of '_widgets.dart';

class CardPost extends StatelessWidget {
  const CardPost({
    required this.optionChoices,
    required this.onOptionChoosed,
    this.isInHistorySection = false,
    this.model,
    this.imageTag,
    this.isReply = false,
    super.key,
    this.onTap,
    this.onImageTap,
    this.onRefreshImage,
  });

  final QuestionModel? model;
  final String? imageTag;
  final VoidCallback? onTap;
  final VoidCallback? onImageTap;
  final VoidCallback? onRefreshImage;
  final List<String> optionChoices;
  final void Function(String?)? onOptionChoosed;
  final bool isReply;
  final bool? isInHistorySection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: BaseColors.white,
        boxShadow: BoxShadowDecorator().defaultShadow(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isReply)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${model!.courseName}',
                      style: FontTheme.poppins10w700black().copyWith(
                        color: BaseColors.mineShaft.withOpacity(0.5),
                      ),
                    ),
                    SmallMenu(
                      choices: optionChoices,
                      onChanged: onOptionChoosed,
                    )
                  ],
                ),
                const HeightSpace(10)
              ],
            )
          else
            const SizedBox.shrink(),
          GestureDetector(
            onTap: onTap,
            child: PostContent(
              isInHistorySection: isInHistorySection,
              isReply: isReply,
              model: model,
              onImageTap: onImageTap ?? onTap,
              onRefreshImage: onRefreshImage,
              imageTag: imageTag,
            ),
          ),
        ],
      ),
    );
  }
}
