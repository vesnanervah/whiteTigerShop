import 'package:flutter/material.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';

class FlowTextFieldEditWidget extends StatefulWidget {
  const FlowTextFieldEditWidget(
      this.onEditClick, this.onSaveClick, this.onCancelClick,
      {super.key});

  final VoidCallback onEditClick;
  final VoidCallback onSaveClick;
  final VoidCallback onCancelClick;

  @override
  State<FlowTextFieldEditWidget> createState() => _FlowTextFieldEditState();
}

class _FlowTextFieldEditState extends State<FlowTextFieldEditWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  var isOpened = false;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  Widget build(BuildContext context) {
    // без constrained при использовании в некоторых виджетах начинает ругаться на бесконечную высоту
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 32, maxWidth: 69),
      child: Flow(
        delegate: FlowEditMenuDelegate(animation: animation),
        children: [
          GestureDetector(
            onTap: () {
              widget.onSaveClick();
              //animation.reverse();
              //setState(() => isOpened = false);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MyColors.accentColor),
              child: const Icon(
                Icons.save,
                color: Colors.white70,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isOpened) {
                animation.reverse();
                widget.onCancelClick();
              } else {
                animation.forward();
                widget.onEditClick();
              }
              setState(() => isOpened = !isOpened);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MyColors.superAccentColor),
              child: Icon(
                isOpened ? Icons.undo : Icons.settings,
                color: Colors.white70,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FlowEditMenuDelegate extends FlowDelegate {
  FlowEditMenuDelegate({required this.animation}) : super(repaint: animation);

  final Animation animation;

  @override
  bool shouldRepaint(FlowEditMenuDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      if (i > 0) dx += 5; // padding
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * animation.value,
          0,
          0,
        ),
      );
    }
  }
}
