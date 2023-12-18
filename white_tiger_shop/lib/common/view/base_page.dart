import 'package:flutter/material.dart';
import 'package:white_tiger_shop/common/data/my_colors.dart';
import 'package:white_tiger_shop/common/model/base_model.dart';
import 'package:white_tiger_shop/common/view/wtshop_app_bar.dart';

class BasePage extends StatefulWidget {
  final BaseModel model;
  final Widget Function() builderCb;
  final VoidCallback onInitCb;
  final String header;
  const BasePage(this.model, this.header, this.onInitCb, this.builderCb,
      {super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
    widget.onInitCb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WtShopAppBar(widget.header),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        color: MyColors.primaryColor,
        child: ListenableBuilder(
          listenable: widget.model,
          builder: (BuildContext context, Widget? child) {
            return widget.model.data == null
                ? Center(
                    child: widget.model.lastFetchErrorMsg == null &&
                            !widget.model.isInitiallyUpdated
                        ? const CircularProgressIndicator(
                            color: MyColors.accentColor,
                          )
                        : Text(widget.model.lastFetchErrorMsg!),
                  )
                : widget.builderCb();
          },
        ),
      ),
    );
  }
}
