import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:white_tiger_shop/common/data/my_colors.dart';
import 'package:white_tiger_shop/common/model/base_model.dart';
import 'package:white_tiger_shop/common/view/wtshop_app_bar.dart';

abstract class BasePage extends StatefulWidget {
  final String title;

  const BasePage(this.title, {super.key});
}

abstract class BasePageState extends State<BasePage> {
  BaseModel? model;

  BasePageState(this.model);

  Widget builderCb(BuildContext context);
  void onInitCb();

  @override
  void initState() {
    super.initState();
    onInitCb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WtShopAppBar(widget.title),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        color: MyColors.primaryColor,
        child: ListenableBuilder(
          listenable: model!,
          builder: (BuildContext context, Widget? child) {
            model != null ? log('model defined') : log('model undefined');
            return model!.data == null
                ? Center(
                    child: model!.lastFetchErrorMsg == null &&
                            !model!.isInitiallyUpdated
                        ? const CircularProgressIndicator(
                            color: MyColors.accentColor,
                          )
                        : Text(model!.lastFetchErrorMsg!),
                  )
                : builderCb(context);
          },
        ),
      ),
    );
  }
}
