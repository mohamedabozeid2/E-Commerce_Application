import 'package:shop_app/models/shop_login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialStates extends ShopLoginStates{}

class ShopLoginChangeVisibility extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}