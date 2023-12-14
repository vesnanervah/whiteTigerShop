import 'package:flutter/material.dart';
import 'package:white_tiger_shop/common/model/base_model.dart';
import 'package:white_tiger_shop/common/view/wtshop_app_bar.dart';

class BasePage extends StatefulWidget {
  final BaseModel model;
  final Widget Function() builderCb;
  final String header;
  const BasePage(this.model, this.header, this.builderCb, {super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
    widget.model.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WtShopAppBar(widget.header),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: widget.model,
          builder: (BuildContext context, Widget? child) {
            return widget.model.data == null
                ? const Center(child: CircularProgressIndicator())
                : widget
                    .builderCb(); // колбек, иначе виджет собирается при передаче параметра
          },
        ),
      ),
    );
  }
}
