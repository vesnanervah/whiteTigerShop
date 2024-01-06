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
  final TextEditingController smsInputController = TextEditingController();
  final TextEditingController emailInputController = TextEditingController();

  @override
  ProfileModel createModel() => context.read<AppState>().profile;

  @override
  void onInitCb() {}

  @override
  Widget buildBody(BuildContext context) {
    return model.isLogedIn!
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello, ${model.email}'),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () {
                      model.logout();
                    },
                    child: const Text('logout',
                        style: TextStyle(color: Colors.white70)))
              ],
            ),
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
                child: model.mailSend
                    ? AuthForm(
                        _formKey,
                        'Введите код из сообщения',
                        'Подтвердить код',
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
                            if (!ProfileRegularExpressions.emailCode
                                .hasMatch(value)) {
                              return 'Код в формате 3 цифр';
                            }
                            return null;
                          },
                        ),
                        () {
                          model
                              .sumbitAuth(smsInputController.value.text)
                              .then((value) {
                            if (value != null && !value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Не правильный код'),
                                ),
                              );
                            }
                          });
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
                        'Введите емейл для входа',
                        'Получить код',
                        TextFormField(
                          controller: emailInputController,
                          decoration: const InputDecoration(
                            labelText: 'Электронная почта',
                            labelStyle: TextStyle(color: Colors.white60),
                            icon: Icon(Icons.email),
                            iconColor: Colors.white60,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Обязательное поле';
                            }
                            if (!ProfileRegularExpressions.email
                                .hasMatch(value)) {
                              return 'В формате example@google.com';
                            }
                            return null;
                          },
                        ),
                        () {
                          model.requestMail(emailInputController.value.text);
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
