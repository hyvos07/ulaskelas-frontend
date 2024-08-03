part of '_widgets.dart';

class SendAsAnonymSwitcher extends StatefulWidget {
  const SendAsAnonymSwitcher({super.key});

  @override
  State<SendAsAnonymSwitcher> createState() => _SendAsAnonymSwitcherState();
}

class _SendAsAnonymSwitcherState extends State<SendAsAnonymSwitcher> {

  bool isAnonym = false;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const QuestionFormLabel(
            text: 'Post sebagai anonym',),
        Transform.scale(
          scale: 0.85,
          child: CupertinoSwitch(
            activeColor: BaseColors.primaryColor!,
            value: isAnonym, 
            onChanged: (v) {
              setState(() {
                isAnonym = v;
              });
            },
          ),
        ),
      ],
    );
  }
}