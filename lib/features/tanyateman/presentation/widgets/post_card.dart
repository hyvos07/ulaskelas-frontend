// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_widgets.dart';

class CardPost extends StatelessWidget {
  const CardPost({
    // required this.model,
    this.isReply = false,
    super.key,
    this.onTap,
  });

  // final CourseModel model;
  final VoidCallback? onTap;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isReply) 
              Column(
                children: [
                  Text(
                    '#Struktur Data dan Algoritma',
                    style: FontTheme.poppins10w700black().copyWith(
                      fontSize: 8, 
                      color: BaseColors.mineShaft.withOpacity(0.7),),
                  ),
                  const HeightSpace(5)
                ],
              ) else const SizedBox.shrink(),
            PostContent(
              isReply: isReply,
            ),
          ],
        )
      ),
    );
  }
}
