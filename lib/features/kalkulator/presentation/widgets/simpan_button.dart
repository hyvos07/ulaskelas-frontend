part of '_widgets.dart';

class SimpanButton extends StatelessWidget {
  const SimpanButton(
      {required this.onTap,
      required this.text,
      super.key,
      this.isLoading = false,
      this.isForAutoFill = false});

  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  final bool? isForAutoFill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: isForAutoFill! ? 14 : 12,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: isForAutoFill!
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: AutoLayoutButton(
        text: text,
        isLoading: isLoading,
        onTap: onTap,
      ),
    );
  }
}
