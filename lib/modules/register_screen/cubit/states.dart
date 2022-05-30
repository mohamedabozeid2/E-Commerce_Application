import 'package:shop_app/models/shop_login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialStates extends ShopRegisterStates{}

class ShopRegisterChangeVisibility extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}