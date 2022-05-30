import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData icon = Icons.visibility;


  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(ShopRegisterChangeVisibility());
  }

  ShopLoginModel? loginModel;

  void userRegister({
    required String? name,
    required String? email,
    required String? password,
    required String? phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name' : name,
        'phone' : phone,
      },
    ).then((value){
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print("You got Error =====> ${error.toString()}" );
      emit(ShopRegisterErrorState());
    });
  }
}
