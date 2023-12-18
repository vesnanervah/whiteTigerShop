import 'package:flutter/material.dart';

class NetworkedImage extends StatelessWidget {
  final double boxHeight;
  final double boxWidth;
  final String? imageUrl;

  const NetworkedImage(this.boxHeight, this.boxWidth, this.imageUrl,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      width: boxWidth,
      child: imageUrl != null
          ? Image.network(
              fit: BoxFit.cover,
              imageUrl!,
              errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) =>
                  Container(
                color: Colors.white10,
                child: const Center(
                  child: Text(
                    'Couldn\'t find the image',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            )
          : const Center(
              child: Text(
                'Image wasn\'t uploaded',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
    );
  }
}
