part of '_pages.dart';

class ViewImagePage extends StatefulWidget {
  const ViewImagePage({
    required this.imageFile,
    super.key,
  });

  final FileImage imageFile;

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  var focusOnImage = false;

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              print('gambar');
              setState(() {
                focusOnImage = false;
              });
            },
            child: InteractiveViewer(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: widget.imageFile,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !focusOnImage,
            child: Column(
              children: [
                SizedBox(
                  width: phoneWidth,
                  height: phoneWidth / 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: phoneWidth / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('back');
                      setState(() {
                        focusOnImage = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
