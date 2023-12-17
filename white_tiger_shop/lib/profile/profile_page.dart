import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
import 'package:white_tiger_shop/main.dart';
import 'package:white_tiger_shop/profile/model/data/profile_reg_exps.dart';
import 'package:white_tiger_shop/profile/model/profile_model.dart';
import 'package:white_tiger_shop/profile/view/auth_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final ProfileRegularExpressions regs = ProfileRegularExpressions();
  final TextEditingController smsInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return BasePage(state.profile, 'Аккаунт', () {}, () {
      return state.profile.isLogedIn!
          ? const Center(
              child: Text('profile page'),
            )
          : Center(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, right: 15, bottom: 25, left: 15),
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: state.profile.smsSend
                      ? AuthForm(
                          _formKey,
                          'Введите код из смс',
                          'Подтвердить смс',
                          TextFormField(
                            controller: smsInputController,
                            decoration: const InputDecoration(
                                labelText: 'Код', icon: Icon(Icons.code)),
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
                            if (smsInputController.value.text ==
                                state.profile.smsCode) {
                              state.profile
                                  .sumbitAuth(smsInputController.value.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Не правильный код')),
                              );
                            }
                          },
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Заполните обязательные поля корректно')),
                            );
                          },
                        )
                      : AuthForm(
                          _formKey,
                          'Введите номер телефона',
                          'Получить смс',
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Номер телефона',
                                icon: Icon(Icons.phone)),
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
                            state.profile.requestSms();
                          },
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Заполните обязательные поля корректно')),
                            );
                          },
                        ),
                ),
              ),
            );
    });
  }
}
