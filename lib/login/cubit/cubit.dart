import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/login/cubit/states.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData icon = Icons.visibility;


  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(ShopLoginChangeVisibility());
  }

  ShopLoginModel? loginModel;

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value){
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print("You got Error =====> ${error.toString()}" );
      emit(ShopLoginErrorState());
    });
  }
}
