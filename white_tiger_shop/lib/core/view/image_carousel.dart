import 'package:flutter/material.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/core/view/networked_image.dart';

class ImageCarousel extends StatefulWidget {
  final List<String?> urls;

  const ImageCarousel(this.urls, {super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  var selectedIndex = 0;

  void selectImage(int index) {
    if (index == selectedIndex) return;
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IndexedStack(
          index: selectedIndex,
          children: widget.urls.isNotEmpty
              ? widget.urls.map((url) => NetworkedImage(200, 200, url)).toList()
              : [const NetworkedImage(200, 200, null)],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 5,
          children: widget.urls
              .map(
                (url) => GestureDetector(
                  onTap: () => selectImage(widget.urls.indexOf(url)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    color: widget.urls.indexOf(url) == selectedIndex
                        ? MyColors.superAccentColor
                        : MyColors.accentColor,
                    child: Text(
                      (widget.urls.indexOf(url) + 1).toString(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
