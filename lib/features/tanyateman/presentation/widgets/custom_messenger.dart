// Original version was Created by Muhamad Fauzi Ridwan on 07/11/21.
// Modified to support custom duration parameter.

part of '_widgets.dart';

class CustomSuccessMessenger {
  CustomSuccessMessenger(this.message, {this.durationMs});

  final String message;
  final int? durationMs;

  void show(BuildContext context) {
    final theme = Theme.of(context);
    Flushbar<void>(
      icon: Container(
        width: 22,
        height: 22,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF27AE60),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      borderRadius: BorderRadius.circular(8),
      duration: Duration(milliseconds: durationMs ?? 1800),
      backgroundColor: const Color(0xFFD4EFDF),
      messageText: Text(
        message.toString(),
        style: theme.textTheme.caption?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ).show(context);
  }
}

class CustomWarningMessenger {
  CustomWarningMessenger(this.message, {this.durationMs});

  final String message;
  final int? durationMs;

  void show(BuildContext context) {
    final theme = Theme.of(context);
    Flushbar<void>(
      icon: Icon(
        Icons.info,
        color: theme.secondaryHeaderColor,
        size: 22,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      borderRadius: BorderRadius.circular(8),
      duration: Duration(milliseconds: durationMs ?? 1800),
      backgroundColor: const Color(0xFFFDF0CC),
      messageText: Text(
        message.toString(),
        style: theme.textTheme.caption?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ).show(context);
  }
}

class CustomErrorMessenger {
  CustomErrorMessenger(this.message, {this.durationMs});

  final String message;
  final int? durationMs;

  void show(BuildContext context) {
    final theme = Theme.of(context);
    Flushbar<void>(
      icon: Icon(
        Icons.error,
        color: theme.colorScheme.error,
        size: 22,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      borderRadius: BorderRadius.circular(8),
      duration: Duration(milliseconds: durationMs ?? 1800),
      backgroundColor: const Color(0xFFFFE0E0),
      messageText: Text(
        message.toString(),
        style: theme.textTheme.caption?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ).show(context);
  }
}
