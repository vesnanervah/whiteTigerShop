import 'package:flutter/material.dart';

class SortToggleBtn extends StatelessWidget {
  final String txt;
  final IconData innerIcon;
  const SortToggleBtn(this.txt, this.innerIcon, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      width: 140,
      child: Row(children: [
        Icon(innerIcon),
        const Padding(padding: EdgeInsets.only(right: 5)),
        Text(txt),
      ]),
    );
  }
}
