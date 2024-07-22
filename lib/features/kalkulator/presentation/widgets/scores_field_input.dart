part of '_widgets.dart';

class ScoresFieldInput extends StatelessWidget {
  const ScoresFieldInput({
    required this.controllers,
    required this.length,
    required this.subtitle,
    required this.onControllerEmpty,
    required this.averageScoreCalculation,
    this.onFieldSubmitted,
    super.key,
  });

  final List<TextEditingController> controllers;
  final int length;
  final Text? subtitle;
  final Function(String, int)? onFieldSubmitted;
  final VoidCallback onControllerEmpty;
  final double Function() averageScoreCalculation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 5),
          childrenPadding: EdgeInsets.zero,
          shape: Border.all(
            color: BaseColors.transparent,
          ),
          collapsedTextColor: BaseColors.neutral100,
          iconColor: BaseColors.neutral100,
          title: Text(
            'Nilai tiap Komponen',
            style: FontTheme.poppins14w400black().copyWith(
              fontSize: 13,
            ),
          ),
          subtitle: subtitle,
          children: [
            for (var i = 0; i < length; i++) _buildSingleField(i),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rata - Rata',
                    style: FontTheme.poppins14w700black().copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    averageScoreCalculation().toStringAsFixed(2),
                    style: FontTheme.poppins14w700black().copyWith(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }

  Widget _buildSingleField(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nilai ${index + 1}',
                style: FontTheme.poppins14w400black().copyWith(
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 35,
                width: 90,
                child: TextFormField(
                  controller: checkController(index),
                  style: FontTheme.poppins12w400black(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  // inputFormatters: <TextInputFormatter>[
                  //   TextInputFormatter.withFunction(
                  //     (oldValue, newValue) {
                  //       if (newValue.text.contains(RegExp('[^0-9]'))) {
                  //         return oldValue;
                  //       }
                  //       return newValue;
                  //     },
                  //   ),
                  // ],
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]+[,.]{0,1}[0-9]*'),
                    ),
                  ],
                  onFieldSubmitted: (value) =>
                      onFieldSubmitted!(value, index + 1),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const HeightSpace(5),
          const Divider(
            color: BaseColors.neutral100,
            thickness: 0.7,
          ),
        ],
      ),
    );
  }

  TextEditingController checkController(int index) {
    if (controllers.isEmpty) {
      onControllerEmpty();
    }
    print(controllers[index]);
    print('this is ${controllers[index].text}');
    return controllers[index];
  }
}
