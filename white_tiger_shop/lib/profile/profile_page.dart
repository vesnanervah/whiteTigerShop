import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/core/application.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/core/page/base_page.dart';
import 'package:white_tiger_shop/profile/model/entities/profile_reg_exps.dart';
import 'package:white_tiger_shop/profile/model/profile_model.dart';
import 'package:white_tiger_shop/profile/view/auth_form.dart';

class ProfilePage extends BasePage {
  const ProfilePage({super.key}) : super('Аккаунт');

  @override
  State<BasePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfileModel, ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final ProfileRegularExpressions regs = ProfileRegularExpressions();
  final TextEditingController smsInputController = TextEditingController();

  @override
  ProfileModel createModel() => context.read<AppState>().profile;

  @override
  void onInitCb() {}

  @override
  Widget builderCb(BuildContext context) {
    return model.isLogedIn!
        ? const Center(
            child: Text('profile page'),
          )
        : Center(
            child: Card(
              color: MyColors.secondaryColor,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 15,
                  bottom: 25,
                  left: 15,
                ),
                constraints: const BoxConstraints(maxWidth: 340),
                child: model.smsSend
                    ? AuthForm(
                        _formKey,
                        'Введите код из смс',
                        'Подтвердить смс',
                        TextFormField(
                          controller: smsInputController,
                          decoration: const InputDecoration(
                            labelText: 'Код',
                            labelStyle: TextStyle(color: Colors.white60),
                            icon: Icon(Icons.numbers),
                            iconColor: Colors.white60,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Обязательное поле';
                            }
                            if (!regs.smsCode.hasMatch(value)) {
                              return 'Код в формате 4 цифр';
                            }
                            return null;
                          },
                        ),
                        () {
                          if (smsInputController.value.text == model.smsCode) {
                            model.sumbitAuth(smsInputController.value.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Не правильный код'),
                              ),
                            );
                          }
                        },
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Заполните обязательные поля корректно'),
                            ),
                          );
                        },
                      )
                    : AuthForm(
                        _formKey,
                        'Введите номер телефона для входа',
                        'Получить смс',
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Номер телефона',
                            labelStyle: TextStyle(color: Colors.white60),
                            icon: Icon(Icons.phone),
                            iconColor: Colors.white60,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Обязательное поле';
                            }
                            if (!regs.phone.hasMatch(value)) {
                              return 'Начинается с +7 и 12 чисел всего.';
                            }
                            return null;
                          },
                        ),
                        () {
                          model.requestSms();
                        },
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Заполните обязательные поля корректно'),
                            ),
                          );
                        },
                      ),
              ),
            ),
          );
  }
}
