import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/model/entities/category.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/core/view/networked_image.dart';

class CategoryItemView extends StatelessWidget {
  final Category category;
  final VoidCallback onClick;
  const CategoryItemView(this.category, this.onClick, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(29, 38, 125, 1),
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashColor: MyColors.accentColor,
        onTap: () => onClick(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(child: NetworkedImage(180, 180, category.imageUrl)),
              const Padding(padding: EdgeInsets.all(5)),
              Text(
                category.title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
