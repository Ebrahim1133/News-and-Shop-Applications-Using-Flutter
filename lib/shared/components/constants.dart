// @dart=2.9
import 'package:flutter_abdullamansour/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_abdullamansour/shared/components/components.dart';
import 'package:flutter_abdullamansour/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

String uId = '';
