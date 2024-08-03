// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_widgets.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    super.key,
    Function()? onBackPress,
    String? label,
    super.actions,
    bool hasLeading = true,
    bool super.centerTitle = true,
    double? elevation,
    Color? color,
    TextStyle? style,
  }) : super(
          elevation: elevation ?? 1,
          shadowColor: Colors.grey[300],
          backgroundColor: color ?? BaseColors.white,
          foregroundColor: color ?? BaseColors.white,
          automaticallyImplyLeading: false,
          leading: hasLeading
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: onBackPress ?? () => nav.pop<void>(),
                )
              : null,
          title: label == null 
            ? null
            : Text(
            label.toString(),
            style: style ?? FontTheme.poppins14w700black(),
          ),
        );
}
