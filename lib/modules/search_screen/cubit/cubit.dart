import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_screen/cubit/states.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);


  SearchModel? model;

  void search(String text){
    emit(SearchLoadingStates());
    DioHelper.postData(
        url: Product_Search,
        token: token,
        data: {
          "text" : text
        }
    ).then((value){
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessStates());
    }).catchError((error){
      print("Error is ---> ${error.toString()}");
      emit(SearchErrorStates());
    });
  }
}