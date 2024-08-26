part of '_widgets.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    this.title,
    this.content,
    this.onConfirm,
    super.key,
  });

  final String? title;
  final String? content;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 70,
      ),
      titlePadding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      title: Text(
        title ?? 'Penghapusan',
        textAlign: TextAlign.center,
        style: FontTheme.poppins16w700black(),
      ),
      contentPadding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 12,
      ),
      content: Text(
        content ?? 'Apakah kamu yakin ingin menghapus data ini?',
        textAlign: TextAlign.center,
        style: FontTheme.poppins14w400black(),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 10,
        bottom: 25,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () => nav.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: BaseColors.accentColor,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Batal',
                style: FontTheme.poppins14w600black().copyWith(
                  color: BaseColors.neutral10,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
            onPressed: onConfirm ??
                () {
                  nav.pop();
                },
            child: Text(
              'Hapus',
              style: FontTheme.poppins14w600black().copyWith(
                color: BaseColors.danger,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
