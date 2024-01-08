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
  var swipeStart = 0.0;
  bool? direction;

  void selectImage(int index) {
    if (index == selectedIndex) return;
    setState(() {
      selectedIndex = index;
      direction = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPressStart: (details) {
            swipeStart = details.localPosition.dx;
          },
          onLongPressMoveUpdate: (details) {
            final delta = swipeStart - details.localPosition.dx;
            if ((delta < 0 && selectedIndex == 0) ||
                (delta > 0 && selectedIndex == widget.urls.length - 1)) {
              // кейс когда мы пытаемся двинуть карусель вправо, а картинок слева больше нет
              // и наоборот
              return;
            }
            if ((delta > 0.0 && delta < 50) ||
                (delta < 0.0 && delta > -50.0) ||
                delta == 0.0) {
              // кейс когда юзер хотел свайпнуть, но передумал, либо прокрутил карусель недостаточно
              setState(() {
                direction = null;
              });
              return;
            }
            setState(() {
              direction = delta > 0;
            });
          },
          onLongPressEnd: (details) {
            var swipeEnd = details.localPosition.dx;
            var delta = swipeStart - swipeEnd;
            if (delta > 50.0 && selectedIndex < widget.urls.length - 1) {
              selectImage(selectedIndex + 1);
            }
            if (delta < -50.0 && selectedIndex > 0) {
              selectImage(selectedIndex - 1);
            }
          },
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 120),
            offset:
                Offset(direction != null ? (direction! ? -0.2 : 0.2) : 0, 0),
            child: IndexedStack(
              index: selectedIndex,
              children: widget.urls.isNotEmpty
                  ? widget.urls
                      .map((url) => NetworkedImage(200, 200, url))
                      .toList()
                  : [const NetworkedImage(200, 200, null)],
            ),
          ),
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
