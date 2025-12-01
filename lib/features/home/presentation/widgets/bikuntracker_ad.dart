part of '_widgets.dart';

class BikunTrackerAd extends StatelessWidget {
  const BikunTrackerAd({super.key});

  @override
  Widget build(BuildContext context) {
    const borderRadiusValue = BorderRadius.all(Radius.circular(12));

    return AspectRatio(
      aspectRatio: 289 / 100,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: borderRadiusValue,
            border: Border.all(color: BaseColors.primary, width: 2),
            color: const Color(0xFFE5E4EA)),
        child: ClipRRect(
          borderRadius:
              borderRadiusValue,
          child: Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/ads/bikuntracker_phone.png',
                  ),
                ),
              ),
              Positioned(
                  bottom: 9,
                  right: 9,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 120, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'BIKUN TRACKER',
                          style: FontTheme.poppins18w700black().copyWith(
                              color: BaseColors.primaryColor, fontSize: 20),
                          textAlign: TextAlign.right,
                        ),
                        const HeightSpace(5),
                        Text(
                          'IS NOW ON APP!',
                          style: FontTheme.poppins18w700black()
                              .copyWith(color: BaseColors.mineShaft),
                          textAlign: TextAlign.right,
                        ),
                        const HeightSpace(5),
                        Text(
                          'Jelajahi fitur terbaru kami \n'
                          'pada versi aplikasi!',
                          style: FontTheme.poppins10w600white().copyWith(
                            color: const Color(0xFF888888),
                            // fontSize: 10
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
