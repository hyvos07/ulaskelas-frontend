part of '_widgets.dart';

class UserProfileBox extends StatelessWidget {
  const UserProfileBox({
    required this.name,
    super.key
  });

  final String name;

  String getInitials() {
    final nameParts = name.split(' ');
    final initials = nameParts[0][0] + nameParts[1][0];
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          getInitials(),
          style: FontTheme.poppins14w700black().copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}