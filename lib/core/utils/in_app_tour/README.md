## TemanKuliah In-App-Tour
In case this feature is developed further in the future, I'll explain a bit about what this actually is.

### 📋 Overview
This in-app tour is built using the [`showcaseview`](https://pub.dev/packages/showcaseview) package and provides a step-by-step interactive tutorial that highlights key features across different pages of the app. You may want to read the documentation first for a quick explanation on how the package works.

The showcase only run when saved SharedPreferences variable named `doneAppTour` equals false or not been set before. That's why you can see several checks on that variable (ex. `Pref.getBool('doneAppTour') == false || Pref.getBool('doneAppTour') == null`) before executing something related to the in-app-tour.

### 📁 Folder Structure
```
in_app_tour/
├── README.md
├── showcase_flow.dart
├── showcase_keys.dart
├── showcase_preview_data.dart
├── containers/
│   ├── showcase_container_matkul.dart
│   ├── showcase_container_calculator.dart
│   └── ...
├── pages/
│   ├── mock_component_states.dart
│   └── mock_komponen_kalkulator_page.dart
└── widgets/
    ├── showcase_wrapper.dart
    ├── animated_image.dart
    └── mock_autofill_dialog.dart
```

1. What is `showcase_flow.dart`?

    This is where the flow of the showcase prepared. There is some variable in here like:

    - Functions
        ```dart
        Function(int index) navbarController = (index) {};
        VoidCallback backToDetailPage = () {};
        VoidCallback openSemesterPage = () {};
        VoidCallback backToMatkulCalcPage = () {};
        ```
        Saving quick callable function for back button functionality

    - Build Contexts
        ```dart
        BuildContext? navbarContext;
        BuildContext? searchPageContext;
        BuildContext? detailMatkulContext;
        BuildContext? tanyaTemanContext;
        ...
        ```
        These are the build contexts that needed to run the showcase on specific page. Needed for `.startShowcase()`

    - Boolean Flags
        ```dart
        bool backFromTanyaTeman = false;
        bool backFromCalculator = false;
        bool backFromNavbarProfile = false;
        bool backFromAddComponent = false;
        ...
        ```
        These are some flags for indicating flow branches and other conditions.

    ... and some functions like `showcaseNavbarTanyaTeman()` to start a showcase. Usually it will be triggered by pressing next on a showcase or when opening a page that triggered (passively) by pressing next button on a showcase.

2. What is `showcase_keys.dart`?

    Basically some `GlobalKeys()` for each showcase wrapper. The keys are the one that indicates which showcase will be showed on the screen.

3. What is `showcase_preview_data.dart`?

    Dummy datas for dummy widgets on the showcase flow.

4. What are `containers/`?

    For shorter codes, I separated the container (of the tooltip) for each showcase in here. You can see each page's workflow tooltip.

5. What are `pages/`?

    Mock pages and its mock state management. Since it's too complicated to use real API hit, I faked it..

6. What are `widgets/`?

    Some special widgets used in these showcases. There is also `showcase_wrapper` that generalize showcase configuration this program used, like padding, place preference, and other else that feels repetitive.


### ⚙️ How To Use

On creating a new in-app-tour steps, you need to:

1. Create a new `GlobalKeys()` in `showcase_keys.dart`
2. Create a function that will trigger your showcase tooltip on `showcase_flow.dart`, also with flags or any other functionality needed
3. Create and saves the tooltip container in `container/`. Don't forget to set previous and next step's next or previous button too so that your showcase is accessible.
4. Wrap your widget/s in a `ShowcaseWrapper()`. If there is several widgets you want to wrap, you can wrap it first with `Column()` or `Row()`

    Example:
    ```dart
    ShowcaseWrapper(
        showcaseKey: inAppTourKeys.emptySemesterGC,
        tooltipPosition: TooltipPosition.bottom,
        targetPadding:
            const EdgeInsets.fromLTRB(10, 10, 10, 0),
        targetBorderRadius: BorderRadius.circular(8),
        container: emptyCalcGCShowcase(context),
        child: _addSemesterButton(index + 1),
    );
    ```

5. Now try to run it from home~

### 💪 Plan in The Future

In case you want to upgrade this flow mechanism, I think I have some recommendation for it:
- Generalize container of the tooltip in `containers/`, like the `ShowcaseWrapper`. I think they are a bit repetitive too
- Create some mock pages for several steps that requires a full page (not in main page with navbar), like detail matkul and else
- Better layout for responsive design

In the end, I wanna say sorry if this considered as not a good approach on making in-app-tour flow. You can always make it better in the future tho :D

<br>

\- DL