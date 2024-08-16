part of '_widgets.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({
    required this.onTap, 
    required this.text, 
    super.key,
    this.isLoading = false,
    this.isOtherTheme = false,
  });

  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  final bool isOtherTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: BaseColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: isOtherTheme
        ? CustomAutoLayoutButton(
            text: text,
            isLoading: isLoading,
            onTap: onTap,
            textStyle: FontTheme.poppins14w400purple(),
            backgroundColor: BaseColors.white,
          )
        : AutoLayoutButton(
            text: text,
            isLoading: isLoading,
            onTap: onTap,
          ),
    );
  }
}


class CustomAutoLayoutButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final Color backgroundColor;

  const CustomAutoLayoutButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onTap,
    required this.textStyle,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: isLoading
              ? []  // No shadow when loading
              : [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  strokeWidth: 2,
                )
              : Text(
                  text,
                  style: textStyle,
                ),
        ),
      ),
    );
  }
}