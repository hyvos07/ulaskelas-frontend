part of '_widgets.dart';

class FrequencyController extends StatelessWidget {
  const FrequencyController({
    required this.onIncrease,
    required this.onDecrease,
    required this.onChangingValue,
    required this.frequencyController,
    this.minFrequency = 1,
    this.maxFrequency = 20,
    super.key,
  });

  final int minFrequency;
  final int maxFrequency;
  final TextEditingController frequencyController;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final Function(int, bool) onChangingValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove,
            size: 22,
          ),
          splashRadius: 15,
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(),
          onPressed: () {
            if (int.parse(frequencyController.text) > minFrequency) {
              onDecrease();
            }
          },
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: frequencyController,
            style: FontTheme.poppins14w400black().copyWith(
              fontSize: 13,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              // FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}$')),
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.contains(RegExp('[^0-9]'))) {
                  return oldValue;
                }
                return newValue;
              }),
            ],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 5,
                right: 2,
              ),
              // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onFieldSubmitted: (value) {
              if (value.trim().isEmpty) {
                ErrorMessenger("This field can't be empty").show(context);
                frequencyController.text = minFrequency.toString();
              } else {
                final parsedValue = int.tryParse(value) ?? minFrequency;
                final isExceed =
                    parsedValue > maxFrequency || parsedValue < minFrequency;
                if (isExceed) {
                  ErrorMessenger(
                    'Frequency must be between $minFrequency and $maxFrequency',
                  ).show(context);
                }
                onChangingValue(parsedValue, isExceed);
              }
              FocusScope.of(context).unfocus();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
        ),
        IconButton(
          icon: const Icon(
            size: 22,
            Icons.add,
          ),
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(),
          splashRadius: 15,
          onPressed: () {
            if (int.parse(frequencyController.text) < maxFrequency) {
              onIncrease();
            }
          },
        ),
      ],
    );
  }
}
