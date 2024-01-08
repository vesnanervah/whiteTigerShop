import 'package:flutter/material.dart';
import 'package:white_tiger_shop/core/view/networked_image.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> urls;

  const ImageCarousel(this.urls, {super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  var selectedIndex = 0;

  void selectImage(int index) => setState(() => selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: widget.urls
                .map((url) => NetworkedImage(180, 180, url))
                .toList(),
          ),
          Wrap(
            children: widget.urls
                .map((url) => GestureDetector(
                      onTap: () => selectImage(widget.urls.indexOf(url)),
                      child: Container(
                        child: Text(widget.urls.indexOf(url).toString()),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
