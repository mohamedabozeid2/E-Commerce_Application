import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/login/cubit/cubit.dart';
import 'package:shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/home_screen.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool visiblePassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
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
                ShopLayoutCubit.get(context).getCategoriesData();
                ShopLayoutCubit.get(context).getFavoriteData();
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
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
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
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        emailFormField(context, emailController),
                        const SizedBox(
                          height: 15.0,
                        ),
                        PasswordFormField(
                          passwordController: passwordController,
                          context: context,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                                text: "Login".toUpperCase(),
                                TextColor: Colors.white,
                                fun: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()
                                )
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w300),
                            ),
                            defaultTextButton(
                              text: "Register",

                              fun: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                            ),
                          ],
                        )
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
