import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/styles/themes.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  bool dataExists=false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        // if (state is ShopSuccessGetUserDataState) {
        //    nameController.text = state.loginModel.data!.name!;
        //    emailController.text = state.loginModel.data!.email!;
        //    phoneController.text = state.loginModel.data!.phone!;
        // }
        if(state is ShopSuccessUpdateUserDataState){
          showToast(msg: ShopLayoutCubit.get(context).updateMessage!);
          /*if(state.loginModel.status!){
            showToast(msg: state.loginModel.message!);
          }else{
            showToast(msg: state.loginModel.message!);
          }*/
        }
      },
      builder: (context, state) {
        if(ShopLayoutCubit.get(context).userModel != null){
          ShopLoginModel? model = ShopLayoutCubit.get(context).userModel!;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        }

        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != null,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    msg: "Name must not be empty",
                    borderRadius: 5.0,
                    isPassword: false,
                    prefixIcon: Icons.person,
                    label: "Name",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    msg: "Email must not be empty",
                    borderRadius: 5.0,
                    isPassword: false,
                    prefixIcon: Icons.email,
                    label: "Email Address",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.number,
                    msg: "Phone must not be empty",
                    borderRadius: 5.0,
                    isPassword: false,
                    prefixIcon: Icons.phone,
                    label: "Phone Number",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    height: 55.0,
                    minWidth: double.infinity,
                    color: defaultColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                              ShopLayoutCubit.get(context).updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                              ShopLayoutCubit.get(context).getUserData();
                      }
                    },
                    child: Text(
                      "Update".toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  signOut(context),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context) =>
              Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }
}
