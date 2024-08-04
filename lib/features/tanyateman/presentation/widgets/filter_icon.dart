part of '_widgets.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 17.5,
          width: 17.5,
        ),
        Icon(
          Icons.filter_alt,
          size: 17.5,
          color: BaseColors.primary,
        ),
        const Positioned(
          top: 0,
          right: 1,
          child: Icon(
            Icons.fiber_manual_record,
            color: Colors.red,
            size: 7.5,
          ),
        )
      ],
    );
  }
}
