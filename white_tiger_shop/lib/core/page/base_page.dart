import 'package:flutter/material.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/core/view/wtshop_app_bar.dart';

abstract class BasePage extends StatefulWidget {
  final String title;

  const BasePage(this.title, {super.key});
}

abstract class BasePageState<M extends BaseModel, S extends BasePage>
    extends State<S> {
  /* Прокидывание модели через наследников базового стейта оказалось чревато тем, что в случаях,
   когда модели брались из контекста (корзина) и имели только один экземпляр
   теперь получают каждый раз по экземпляру при построении.
   Возможно такие модели надо сделать singleton  
  */
  late final M model;

  BasePageState();

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
          listenable: model,
          builder: (BuildContext context, Widget? child) {
            return model.data == null
                ? Center(
                    child: model.lastFetchErrorMsg == null &&
                            !model.isInitiallyUpdated
                        ? const CircularProgressIndicator(
                            color: MyColors.accentColor,
                          )
                        : Text(model.lastFetchErrorMsg!),
                  )
                : builderCb(context);
          },
        ),
      ),
    );
  }
}