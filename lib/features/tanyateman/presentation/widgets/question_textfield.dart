part of '_widgets.dart';

class QuestionTextField extends StatelessWidget {
  const QuestionTextField({
    required this.controller,
    required this.onChanged,
    required this.validator,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 12,
      style: FontTheme.poppins12w400black(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Apa yang ingin kamu tanyakan?',
      ),
      textInputAction: TextInputAction.newline,
      onChanged: onChanged,
      validator: validator,
    );
  }
}