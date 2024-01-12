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
  late final M model = createModel();

  M createModel();

  Widget buildBody(BuildContext context);

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
            return !model.isInitiallyUpdated
                ? Center(
                    child: model.isLoading
                        ? const CircularProgressIndicator(
                            color: MyColors.accentColor,
                          )
                        : Text(
                            model.lastFetchErrorMsg ?? 'Что-то пошло не так',
                          ),
                  )
                : buildBody(context);
          },
        ),
      ),
    );
  }
}
