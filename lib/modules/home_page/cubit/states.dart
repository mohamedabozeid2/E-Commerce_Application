import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/shop_login_model.dart';

abstract class ShopLayoutStates{}

class ShopLayoutInitialStates extends ShopLayoutStates{}

class ShopLayoutChangeBotNavState extends ShopLayoutStates{}

class ShopLoadingHomeDataState extends ShopLayoutStates{}

class ShopSuccessHomeDataState extends ShopLayoutStates{}

class ShopErrorHomeDataState extends ShopLayoutStates{}

class ShopSuccessCategoryDataState extends ShopLayoutStates{}

class ShopErrorCategoryDataState extends ShopLayoutStates {}

class ShopChangeFavoriteState extends ShopLayoutStates{}

class ShopSuccessFavoriteState extends ShopLayoutStates{
  final ChangeFavoriteModel model;
  int index;

  ShopSuccessFavoriteState(this.model, this.index);
}

class ShopErrorFavoriteState extends ShopLayoutStates{}

class ShopLoadingGetFavoriteDataState extends ShopLayoutStates{}

class ShopSuccessGetFavoriteDataState extends ShopLayoutStates{}

class ShopErrorGetFavoriteDataState extends ShopLayoutStates {}

class ShopLoadingGetUserDataState extends ShopLayoutStates{}

class ShopSuccessGetUserDataState extends ShopLayoutStates{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);

}

class ShopErrorGetUserDataState extends ShopLayoutStates {}


class ShopLoadingUpdateUserDataState extends ShopLayoutStates{}

class ShopSuccessUpdateUserDataState extends ShopLayoutStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);

}

class ShopErrorUpdateUserDataState extends ShopLayoutStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}

