import 'package:flutter/material.dart';

abstract class BaseModel<T> extends ChangeNotifier {
  T? data;
  Future<void> fetch();
  Future<void> update() async {
    await fetch();
    notifyListeners();
  }
}
