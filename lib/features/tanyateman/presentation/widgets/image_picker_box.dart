part of '_widgets.dart';

class ImagePickerBox extends StatelessWidget {
  const ImagePickerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: DottedBorder(
        dashPattern: const [15, 10],
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        color: BaseColors.primaryColor!,
        strokeWidth: 1.5,
        child: SizedBox(
          height: 135,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Upload Gambar', 
                style: FontTheme.poppins14w700black()
                  .copyWith(color: Colors.blue),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Jpeg/Png/Jpg Max 5 Mb',
                    style: FontTheme.poppins10w400black(),),
                  Text(
                    '*',
                    style: FontTheme.poppins10w400black()
                      .copyWith(color: Colors.red),),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}