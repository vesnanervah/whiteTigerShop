class ProfileRegularExpressions {
  static RegExp phone = RegExp(r'^\+7[0-9]{10}$');
  static RegExp smsCode = RegExp(r'^[0-9]{4}');
  static RegExp emailCode = RegExp(r'^[0-9]{3}');
  static RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp name = RegExp(r'^[A-Za-zА-Яа-я]');
}
