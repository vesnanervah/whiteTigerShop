import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:white_tiger_shop/core/controller/entity/meta_with_unsuccess_exception.dart';

abstract class BaseModel extends ChangeNotifier {
  bool isInitiallyUpdated = false;
  String? lastFetchErrorMsg;
  bool isLoading = false;

  Future<void> fetch();

  Future<void> update() async {
    if (isLoading) return;
    isLoading = true;
    lastFetchErrorMsg = null;
    notifyListeners();
    try {
      await fetch();
      if (!isInitiallyUpdated) isInitiallyUpdated = true;
    } on MetaWithUnsuccesException catch (e) {
      lastFetchErrorMsg = e.errorMsg;
      log(lastFetchErrorMsg!);
    } on ClientException catch (_) {
      lastFetchErrorMsg =
          'Проблема с подключением. Проверьте интернет или попробуйте позже';
    } on Exception catch (_) {
      lastFetchErrorMsg = 'I am a teapot';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
