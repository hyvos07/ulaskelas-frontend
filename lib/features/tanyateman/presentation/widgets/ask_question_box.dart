part of '_widgets.dart';

class AskQuestionBox extends StatelessWidget {
  const AskQuestionBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.only(left: 10),
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(.15),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionFormLabel(
              text: 'Kebingungan? Tanya Teman!',
              color: BaseColors.mineShaft.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }
}