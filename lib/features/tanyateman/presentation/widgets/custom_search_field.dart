part of '_widgets.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
    this.onQueryChanged,
    this.onClear,
    this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final Function(String?)? onFieldSubmitted;
  final Function(String)? onQueryChanged;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: FontTheme.poppins12w500black(),
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onQueryChanged,
      decoration: InputDecoration(
        hintText: hintText ?? 'Search',
        prefixIcon: const Icon(
          Icons.search,
          size: 20,
          color: BaseColors.gray3,
        ),
        fillColor: BaseColors.white,
        filled: true,
        hintStyle: FontTheme.poppins12w500black().copyWith(
          color: BaseColors.gray3,
        ),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: BaseColors.gray3.withOpacity(0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: BaseColors.primary),
        ),
        suffixIcon: focusNode.hasFocus || controller.text.isNotEmpty
            ? InkWell(
                onTap: onClear ?? () {},
                child: const Icon(
                  Icons.clear,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}
