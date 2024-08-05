part of '_widgets.dart';

class UserProfileBox extends StatelessWidget {
  const UserProfileBox({required this.name, super.key});

  final String name;

  String? _getInitials(String name) {
    String shortName;

    shortName = name.split(' ').fold<String>(
          '',
          (previousValue, element) =>
              previousValue + element.substring(0, min(element.length, 1)),
        );

    shortName = shortName.substring(0, min(shortName.length, 2));

    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(shortName)) {
      return shortName.characters.first.toUpperCase();
    }

    return shortName;
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
          _getInitials(name)!,
          style: FontTheme.poppins14w700black().copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
