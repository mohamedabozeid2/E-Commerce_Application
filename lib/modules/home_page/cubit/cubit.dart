import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home_page/cubit/states.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialStates());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart,
        ),
        label: "Products"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: "Category"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorites",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
  ];

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBotNav(index) {
    currentIndex = index;

    emit(ShopLayoutChangeBotNavState());
  }

  HomeModel? homeModel;

  void getHomeData() async{
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorite!,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      debugPrint("You Got Error =====> ${error.toString()}");
      emit(ShopErrorHomeDataState());
    });
  }

  Map<int, bool> favorites = {};
  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int productId, int index) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
      url: FAVORITES,
      data: {"product_id": productId},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if (!changeFavoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoriteData();
      }

      printFullText(value.data.toString());
      emit(ShopSuccessFavoriteState(changeFavoriteModel!, index));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print("You Got Error => ${error.toString()}");
      emit(ShopErrorFavoriteState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      debugPrint("You Got Error ================> ${error.toString()}");
      emit(ShopErrorCategoryDataState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(ShopLoadingGetFavoriteDataState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavoriteDataState());
    }).catchError((error) {
      debugPrint("You Got Error ================> bitch ${error.toString()}");
      emit(ShopErrorGetFavoriteDataState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      debugPrint(
          "You Got Error ================> bitch bitch ${error.toString()}");
      emit(ShopErrorGetUserDataState());
    });
  }

  String? updateMessage;
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      if(ShopLoginModel.fromJson(value.data).data != null){
        userModel = ShopLoginModel.fromJson(value.data);
      }
      updateMessage = ShopLoginModel.fromJson(value.data).message;
      printFullText(userModel!.data!.name);
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      debugPrint(
          "You Got Error ================> bitch bitch bitch ${error.toString()}");
      emit(ShopErrorUpdateUserDataState(error));
    });
  }
}
