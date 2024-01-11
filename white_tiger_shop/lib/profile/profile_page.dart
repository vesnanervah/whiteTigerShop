import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/core/application.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/core/page/base_page.dart';
import 'package:white_tiger_shop/profile/model/entities/profile_reg_exps.dart';
import 'package:white_tiger_shop/profile/model/profile_model.dart';
import 'package:white_tiger_shop/profile/view/auth_form.dart';
import 'package:white_tiger_shop/profile/view/flow_textfield_edit.dart';

class ProfilePage extends BasePage {
  const ProfilePage({super.key}) : super('Аккаунт');

  @override
  State<BasePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfileModel, ProfilePage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  final _adressFormKey = GlobalKey<FormState>();
  final TextEditingController smsInputController = TextEditingController();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController adressInputController = TextEditingController();
  var isNameEdit = false;
  var isAdressEdit = false;

  void listenUserDataUpdate() {
    nameInputController.text = model.user?.name ?? 'Не указано';
    adressInputController.text = model.user?.adress ?? 'Не указано';
  }

  @override
  ProfileModel createModel() => context.read<AppState>().profile;

  @override
  void onInitCb() {
    listenUserDataUpdate();
    model.addListener(() => listenUserDataUpdate);
  }

  @override
  void dispose() {
    model.removeListener(() => listenUserDataUpdate);
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return model.user != null
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello, ${model.user!.email}'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Ваши данные',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Form(
                  key: _nameFormKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        enabled: isNameEdit,
                        controller: nameInputController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Не должно быть пустым';
                          }
                          return ProfileRegularExpressions.name.hasMatch(value)
                              ? null
                              : 'Только буквы латиницы и кириллицы';
                        },
                        decoration: const InputDecoration(
                          label: Text('Имя'),
                          constraints: BoxConstraints(maxWidth: 340),
                          labelStyle: TextStyle(color: Colors.white60),
                          icon: Icon(Icons.person),
                          iconColor: Colors.white60,
                        ),
                      ),
                      Container(
                        constraints:
                            const BoxConstraints(maxHeight: 36, maxWidth: 77),
                        child: FlowTextFieldEditWidget(
                          () => setState(() {
                            nameInputController.text = '';
                            isNameEdit = true;
                          }),
                          () {
                            if (_nameFormKey.currentState!.validate()) {
                              if (model.isLoading) return;
                              model
                                  .changeUserName(nameInputController.text)
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(value
                                            ? 'Имя успешно обновлено'
                                            : 'Что-то пошло не так'),
                                      ),
                                    ),
                                  );
                            }
                          },
                          () {
                            nameInputController.text =
                                model.user!.name ?? 'Не указано';
                            setState(() {
                              isNameEdit = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _adressFormKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value!.isNotEmpty ? null : 'Не должно быть пустым',
                        enabled: isAdressEdit,
                        controller: adressInputController,
                        decoration: const InputDecoration(
                          label: Text('Адрес'),
                          constraints: BoxConstraints(maxWidth: 340),
                          labelStyle: TextStyle(color: Colors.white60),
                          icon: Icon(Icons.location_city),
                          iconColor: Colors.white60,
                        ),
                      ),
                      Container(
                        constraints:
                            const BoxConstraints(maxHeight: 36, maxWidth: 77),
                        child: FlowTextFieldEditWidget(
                          () => setState(() {
                            adressInputController.text = '';
                            isAdressEdit = true;
                          }),
                          () {
                            if (model.isLoading) return;
                            if (_adressFormKey.currentState!.validate()) {
                              model
                                  .changeUserAdress(adressInputController.text)
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                          content: Text(value
                                              ? 'Адрес успешно обновлен'
                                              : 'Что-то пошло не так')),
                                    ),
                                  );
                            }
                          },
                          () {
                            setState(() {
                              adressInputController.text =
                                  model.user!.adress ?? 'Не указано';
                              isAdressEdit = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                        _loginFormKey,
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
                        _loginFormKey,
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
