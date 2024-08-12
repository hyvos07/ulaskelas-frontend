part of '_widgets.dart';

class SendAsAnonymSwitcher extends StatelessWidget {
  const SendAsAnonymSwitcher({
    required this.isAnonym,
    required this.onChanged,
    super.key,
  });

  final bool isAnonym;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const QuestionFormLabel(
          text: 'Post sebagai anonym',
        ),
        Transform.scale(
          scale: 0.85,
          child: CupertinoSwitch(
            activeColor: BaseColors.primaryColor,
            value: isAnonym,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
