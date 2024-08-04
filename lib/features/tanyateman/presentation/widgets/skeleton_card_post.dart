part of '_widgets.dart';

class SkeletonCardPost extends StatelessWidget {
  const SkeletonCardPost({
    required this.isReply,
    super.key,
  });

  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: BaseColors.white,
        boxShadow: BoxShadowDecorator().defaultShadow(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isReply)
              Column(
                children: [
                  Container(
                    height: 7,
                    width: 150,
                    decoration: BoxDecoration(
                      color: BaseColors.gray2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
            const HeightSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: BaseColors.gray2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const WidthSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 120,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: BaseColors.gray2,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              const WidthSpace(5),
                            ],
                          ),
                          const HeightSpace(7),
                          Container(
                            width: 100,
                            height: 8,
                            decoration: BoxDecoration(
                              color: BaseColors.gray2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const HeightSpace(12),
                Container(
                  width: 270,
                  height: 8,
                  decoration: BoxDecoration(
                    color: BaseColors.gray2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const HeightSpace(5),
                Container(
                  width: (Random().nextInt(200) + 70).toDouble(), // 70 - 270
                  height: 8,
                  decoration: BoxDecoration(
                    color: BaseColors.gray2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const HeightSpace(12),
                Container(
                  width: 100,
                  height: 6,
                  decoration: BoxDecoration(
                    color: BaseColors.gray2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
