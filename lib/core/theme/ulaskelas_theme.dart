part of '_theme.dart';

class UlaskelasThemeImpl implements UlaskelasTheme {
  ThemeData _baseThemeData() {
    return ThemeData(
      brightness: Brightness.light,
    );
  }

  @override
  ThemeData normalTheme() {
    return _baseThemeData().copyWith(
      primaryColor: BaseColors.purpleHearth,
      secondaryHeaderColor: BaseColors.goldenrod,
      shadowColor: BaseColors.gray5,
      textTheme: TextTheme(
        bodySmall: FontTheme.poppins12w400black(),
        labelLarge: FontTheme.poppins14w700black().copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: FontTheme.poppins12w400black().copyWith(
          color: BaseColors.gray2,
        ),
        fillColor: BaseColors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: BaseColors.gray3),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: BaseColors.purpleHearth),
          borderRadius: BorderRadius.circular(4),
        ),
        prefixIconColor: BaseColors.gray3,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return BaseColors.purpleHearth;
          }
          return BaseColors.transparent;
        }),
        checkColor: MaterialStateProperty.all(BaseColors.white),
        side: const BorderSide(color: BaseColors.gray3),
      ),
      dialogBackgroundColor: BaseColors.white,
      dividerColor: BaseColors.gray5,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: BaseColors.alabaster,
        backgroundColor: BaseColors.alabaster,
        iconTheme: IconThemeData(color: BaseColors.mineShaft),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          surfaceTintColor: MaterialStateProperty.all(BaseColors.white),
          backgroundColor: MaterialStateProperty.all(BaseColors.white),
        ),
      ),
      colorScheme: const ColorScheme(
        primary: BaseColors.purpleHearth,
        primaryContainer: BaseColors.malibu,
        secondary: BaseColors.mineShaft,
        secondaryContainer: BaseColors.cerise,
        surface: BaseColors.alabaster,
        background: BaseColors.white,
        error: BaseColors.error,
        onPrimary: BaseColors.purpleHearth,
        onSecondary: BaseColors.mineShaft,
        onSurface: BaseColors.alabaster,
        onBackground: BaseColors.white,
        onError: BaseColors.error,
        brightness: Brightness.light,
      ),
    );
  }

  @override
  ThemeData darkTheme() {
    return _baseThemeData().copyWith(
      primaryColor: BaseColors.mineShaft,
      secondaryHeaderColor: BaseColors.mineShaft,
    );
  }

  @override
  ThemeData mapTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.dark:
        return darkTheme();
      case ThemeType.normal:
        return normalTheme();
    }
  }
}
