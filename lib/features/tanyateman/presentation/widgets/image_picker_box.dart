part of '_widgets.dart';

class ImagePickerBox extends StatelessWidget {
  const ImagePickerBox({
    required this.onTapUpload, 
    required this.onTapSeeImage,
    this.isImageSizeTooBig,
    super.key
  });

  final VoidCallback onTapUpload;
  final VoidCallback onTapSeeImage;
  final bool? isImageSizeTooBig;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapUpload,
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
                isImageSizeTooBig == null 
                  ? 'Upload Gambar'
                  : isImageSizeTooBig!
                      ? 'Upload Gambar'
                      : 'Reupload Gambar', 
                style: FontTheme.poppins14w700black()
                  .copyWith(color: Colors.blue),),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Jpeg/Png/Jpg Max 5 MB',
                        style: FontTheme.poppins10w400black(),),
                      Text(
                        '*',
                        style: FontTheme.poppins10w400black()
                          .copyWith(color: Colors.red),),
                    ],
                  ),
                  if (isImageSizeTooBig != null) 
                    Column(
                      children: [
                        const HeightSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isImageSizeTooBig!) 
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 18,),
                                  const WidthSpace(5),
                                  GestureDetector(
                                    onTap: onTapSeeImage,
                                    child: Text(
                                      'Gambar',
                                      style: FontTheme.poppins12w700black().copyWith(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  Text(
                                    ' berhasil ditambahkan',
                                    style: FontTheme.poppins12w400black(),
                                  )
                                ],
                              )
                            else
                              Row(
                                children: [
                                  const Icon(
                                    Icons.warning_rounded,
                                    color: Colors.red,),
                                  const WidthSpace(5),
                                  Text(
                                    'Error,',
                                    style: FontTheme.poppins12w700black().copyWith(
                                      color: Colors.red,),
                                  ),
                                  Text(
                                    ' gambar melebihi 5 MB',
                                    style: FontTheme.poppins12w400black(),
                                  )
                                ],
                              )
                          ],
                        ),
                      ],
                    )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
