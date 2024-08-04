part of '_widgets.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    required this.filterOn,
    super.key,
  });

  final bool filterOn;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.filter_alt,
          size: 20,
          color: BaseColors.primary,
        ),
        if (filterOn)
          const Positioned(
            top: 0,
            right: 1,
            child: Icon(
              Icons.fiber_manual_record,
              color: Colors.red,
              size: 8,
            ),
          )
      ],
    );
  }
}
