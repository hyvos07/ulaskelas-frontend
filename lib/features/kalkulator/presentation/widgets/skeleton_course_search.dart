part of '_widgets.dart';

class SkeletonCourseSearch extends StatelessWidget {
  const SkeletonCourseSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: BaseColors.white,
        boxShadow: BoxShadowDecorator().defaultShadow(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            Container(
              height: 8,
              width: 120 + Random().nextDouble() * 20,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
