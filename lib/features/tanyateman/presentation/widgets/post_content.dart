part of '_widgets.dart';

class PostContent extends StatelessWidget {
  const PostContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children:[ 
        Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'AD',
                  style: FontTheme.poppins14w700black().copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Adrian Hamzah',
                        style: FontTheme.poppins10w700black().copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Text(
                        '2 Hour ago',
                        style: FontTheme.poppins10w400black().copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(4),
                  Text(
                    'Ilmu Komputer 2022',
                    style: FontTheme.poppins10w400black().copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const HeightSpace(5),
        Text(
          'Halo guys, disini ada yang tau tips & trik ketika ngasdos SDA ga yaa?',
          style: FontTheme.poppins12w600black(),
        ),
        const HeightSpace(5),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/thumbsup.svg',
              height: 16, width: 16,
            ),
            Text(
              '22',
              style: FontTheme.poppins10w400black().copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
              ),
            ),
            const WidthSpace(5),
            SvgPicture.asset(
              'assets/icons/comment.svg',
              height: 16, width: 16,
            ),
            const WidthSpace(3.5),
            Text(
              '2',
              style: FontTheme.poppins10w400black().copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
              ),
            ),
            const WidthSpace(10),
            Text(
              '|  2 Aug 2024 03.32',
              style: FontTheme.poppins10w400black().copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
              ),
            )
          ],
        )
      ]
    );
  }
}