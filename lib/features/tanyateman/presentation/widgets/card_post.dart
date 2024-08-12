// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_widgets.dart';

class CardPost extends StatelessWidget {
  const CardPost({
    this.model,
    this.isReply = false,
    super.key,
    this.onTap,
  });

  final QuestionModel? model;
  final VoidCallback? onTap;
  final bool isReply;

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
                        '#${model!.tags}',
                        style: FontTheme.poppins10w700black().copyWith(
                          color: BaseColors.mineShaft.withOpacity(0.5),
                        ),
                      ),
                      SmallMenu(
                        choices: const ['Report', 'Salin Tautan'],
                        onChanged: (value) {
                          if (kDebugMode) {
                            print('User choose to: $value');
                          }
                        },
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
                isReply: isReply,
                model: model,
                onImageTap: onTap,
              ),
            ),
          ],
        ));
  }
}
