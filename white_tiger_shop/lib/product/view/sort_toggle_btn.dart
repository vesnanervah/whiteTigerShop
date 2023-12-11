import 'package:flutter/material.dart';

class SortToggleButon extends StatelessWidget {
  final double width;
  final String txt;
  const SortToggleButon(this.txt, this.width, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(txt),
      ),
    );
  }
}
