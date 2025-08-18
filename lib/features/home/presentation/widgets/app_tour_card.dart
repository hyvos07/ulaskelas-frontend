part of '_widgets.dart';

class AppTourCard extends StatelessWidget {
  const AppTourCard({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: BaseColors.neutral100.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                const WidthSpace(84),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Lupa cara pakai TemanKuliah? '
                        'Yuk, ulangi tur bareng Ruby.',
                        style: FontTheme.poppins14w600black(),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 14),
                      PrimaryButton(
                        onPressed: onTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Ulangi Tur',
                            style: FontTheme.poppins12w600black().copyWith(
                              color: BaseColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/ruby/ruby_wave.png',
            height: 135,
          ),
        ),
      ],
    );
  }
}
