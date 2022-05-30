import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/home_screen.dart';
import 'package:shop_app/modules/register_screen/cubit/cubit.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context , state) {
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(key: "token", value: state.loginModel.data!.token!).then((value){
                token = state.loginModel.data!.token!;
                navigateAndFinish(context : context,widget:  ShopLayout());
                showToast(
                  msg: state.loginModel.message!,
                  textColor: Colors.white,
                  color: Colors.green,
                );
                ShopLayoutCubit.get(context).getUserData();
                ShopLayoutCubit.get(context).getFavoriteData();
                ShopLayoutCubit.get(context).getCategoriesData();
                print("token is $token");
              });
            }
            else{
              print(state.loginModel.message);
              showToast(
                  msg: state.loginModel.message!,
                  color: Colors.red,
                  textColor: Colors.white
              );
            }
          }
        },
        builder:  (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Register"),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            msg: "Name must not be empty",
                            borderRadius: 5.0,
                            isPassword: false,
                            prefixIcon: Icons.person,
                            label: "User Name"
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        emailFormField(context, emailController),
                        const SizedBox(
                          height: 15.0,
                        ),
                        PasswordRegisterFormField(
                          passwordController: passwordController,
                          context: context,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            msg: "phone must not be empty",
                            borderRadius: 5.0,
                            isPassword: false,
                            prefixIcon: Icons.phone,
                            label: "Phone Number"
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) =>
                                defaultButton(
                                    text: "REGISTER",
                                    TextColor: Colors.white,
                                    fun: () {
                                      if (formKey.currentState!.validate()) {
                                        ShopRegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                        );
                                      }
                                    }),
                            fallback: (context) =>
                            const Center(child: CircularProgressIndicator()
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
