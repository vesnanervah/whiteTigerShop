import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String header;
  final String submitBtnText;
  final VoidCallback onValialidSubmitClick;
  final VoidCallback onInvalidSubmitClick;
  final TextFormField field;
  const AuthForm(this.formKey, this.header, this.submitBtnText, this.field,
      this.onValialidSubmitClick, this.onInvalidSubmitClick,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 17, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          field,
          const SizedBox(height: 20),
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () => formKey.currentState!.validate()
                ? onValialidSubmitClick()
                : onInvalidSubmitClick(),
            child: Text(
              submitBtnText,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
