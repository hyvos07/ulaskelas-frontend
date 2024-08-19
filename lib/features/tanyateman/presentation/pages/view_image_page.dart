part of '_pages.dart';

class ViewImagePage extends StatefulWidget {
  const ViewImagePage({
    required this.imageFile,
    this.imageTag,
    this.enableImagePreview = false,
    super.key,
  });

  final ImageProvider imageFile;
  final bool enableImagePreview;
  final String? imageTag;

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  bool focusOnImage = false;

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;
    print('displaying ${widget.imageTag}');
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
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: widget.enableImagePreview
                    ? Hero(
                        tag: '${widget.imageTag}',
                        flightShuttleBuilder: (
                          flightContext,
                          animation,
                          direction,
                          fromContext,
                          toContext,
                        ) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Container(
                                child: child,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: widget.imageFile,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: widget.imageFile,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.imageFile,
                            fit: BoxFit.contain,
                          ),
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
                            )),
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
