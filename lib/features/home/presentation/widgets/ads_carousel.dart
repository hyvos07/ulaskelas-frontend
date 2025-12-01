part of '_widgets.dart';

class AdsCarousel extends StatefulWidget {
  const AdsCarousel({
    super.key,
    required this.items, // 1. Wajib menerima list widget dari luar
  });

  final List<Widget> items; // 2. Variabel penampung

  @override
  State<AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    // Hapus logika List.generate disini, kita pakai widget.items langsung

    return Column(
      children: [
        CarouselSlider(
          items: widget.items, // 3. Pakai parameter widget.items
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 312 / 124,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dotted Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // 4. Loop berdasarkan jumlah items yang dikirim
          children: widget.items.asMap().entries.map((entry) {
            final bool isActive = _current == entry.key;

            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isActive ? 30.0 : 10.0,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isActive
                      ? BaseColors.primary
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
