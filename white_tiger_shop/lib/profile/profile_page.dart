import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
import 'package:white_tiger_shop/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Введите номер телефона'),
                          TextFormField(),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Войти'))
                        ]),
                  ),
                ),
              ),
            );
    });
  }
}
