import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/modules/lightbox_images/lightbox_images_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LightBoxImages extends StatefulWidget {
  final LightBoxImagesPresenter controller;
  final List<String> imageUrls;
  final Widget child;

  const LightBoxImages({
    Key key,
    @required this.child,
    @required this.imageUrls,
    this.controller,
  }) : super(key: key);

  @override
  State<LightBoxImages> createState() => _LightBoxImagesState();
}

class _LightBoxImagesState extends State<LightBoxImages>
    implements LightBoxImagesContract {
  LightBoxImagesPresenter _presenter;

  bool isLightBoxOpened = false;

  String currentImageURL = '';

  @override
  void initState() {
    super.initState();
    if (widget.controller == null)
      _presenter = LightBoxImagesPresenter();
    else
      _presenter = widget.controller;
    _presenter.attach(this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageWidth = size.width / 1.2;

    int currentImageIndex = widget.imageUrls.indexOf(currentImageURL);

    bool hasCurrentImage = currentImageIndex != -1;
    bool hasNextImage = currentImageIndex + 1 <= widget.imageUrls.length - 1;
    bool hasPreviousImage = currentImageIndex - 1 >= 0;

    TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    Widget previousImageButton = hasPreviousImage && hasCurrentImage
        ? TextButton.icon(
            onPressed: () => _presenter
                .openImageURL(widget.imageUrls[currentImageIndex - 1]),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            label: Text(
              'Önceki',
              style: buttonTextStyle,
            ),
          )
        : SizedBox();

    Widget nextImageButton = hasNextImage && hasCurrentImage
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
              onPressed: () => _presenter
                  .openImageURL(widget.imageUrls[currentImageIndex + 1]),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              label: Text(
                'Sonraki',
                style: buttonTextStyle,
              ),
            ),
          )
        : SizedBox();

    Widget image = Container(
      width: imageWidth,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: CachedNetworkImage(
          imageUrl: currentImageURL,
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget closeButton = TextButton(
      onPressed: () => _presenter.close(),
      child: Text(
        'X Kapat',
        style: buttonTextStyle,
      ),
    );

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: previousImageButton,
            ),
            Expanded(
              child: nextImageButton,
            ),
          ],
        ),
        closeButton,
      ],
    );

    return Stack(
      children: [
        widget.child,
        if (isLightBoxOpened)
          if (currentImageURL != null && currentImageURL.isNotEmpty)
            Container(
              height: size.height,
              width: size.width,
              color: Colors.black.withOpacity(0.5),
              child: content,
            ),
      ],
    );
  }

  @override
  onClose() {
    setState(() {
      isLightBoxOpened = false;
    });
  }

  @override
  onOpen() {
    setState(() {
      isLightBoxOpened = true;
    });
  }

  @override
  onOpenImageURL(String _url) {
    setState(() {
      currentImageURL = _url;
      isLightBoxOpened = true;
    });
  }
}
