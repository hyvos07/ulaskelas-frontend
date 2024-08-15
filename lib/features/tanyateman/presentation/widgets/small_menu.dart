part of '_widgets.dart';

class SmallMenu extends StatelessWidget {
  const SmallMenu({
    required this.choices,
    this.onChanged,
    super.key,
  });

  final List<String> choices;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.more_horiz,
          color: BaseColors.mineShaft,
          size: 16,
        ),
        items: List.generate(
          choices.length,
          (index) => DropdownMenuItem(
            value: choices[index],
            child: Text(
              choices[index],
              style: FontTheme.poppins12w500black(),
            ),
          ),
        ),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          width: 120,
          direction: DropdownDirection.left,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: BaseColors.white,
          ),
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 35,
        ),
      ),
    );
  }
}
