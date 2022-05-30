import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/login/cubit/cubit.dart';
import 'package:shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/register_screen/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/styles/themes.dart';


Widget myDividor({required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 2,
      color: color,
    ),
  );
}

void navigateAndFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void showToast({
  required String msg,
  Color color = Colors.white,
  Color textColor = Colors.black,

}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: textColor,
      fontSize: 16.0
  );
}

Widget PasswordFormField({
  context,
  required TextEditingController passwordController,
}) {
  return TextFormField(
    controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "You Must Enter Your Password";
      }
    },
    obscureText: ShopLoginCubit.get(context).isPassword,
    decoration: InputDecoration(
        label: const Text("Password"),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(ShopLoginCubit.get(context).icon),
          onPressed: () {
            ShopLoginCubit.get(context).changeVisibility();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ))),
  );
}

Widget PasswordRegisterFormField({
  context,
  required TextEditingController passwordController,
}) {
  return TextFormField(
    controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "You Must Enter Your Password";
      }
    },
    obscureText: ShopRegisterCubit.get(context).isPassword,
    decoration: InputDecoration(
        label: const Text("Password"),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(ShopRegisterCubit.get(context).icon),
          onPressed: () {
            ShopRegisterCubit.get(context).changeVisibility();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ))),
  );
}

Widget emailFormField(context, emailController) {
  return TextFormField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "You Must Enter Your Email Address";
      }
    },
    decoration: InputDecoration(
        label: const Text(
          "Email Address",
        ),
        prefixIcon: const Icon(
          Icons.email,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black))),
  );
}

Widget defaultButton({
  double width = double.infinity,
  double height = 55,
  Color backgroundColor = Colors.blue,
  double borderRadius = 5.0,
  String? text,
  bool isUpperCase = false,
  Color? TextColor,
  required fun,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: fun,
      child: Text(
        isUpperCase ? text!.toUpperCase() : text!,
        style: TextStyle(
          color: TextColor,
          fontSize: 15,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
    ),
  );
}

Widget defaultTextButton(
    {required String text,
    required fun,
    double fontSize = 14,
    FontWeight weight = FontWeight.w300}) {
  return TextButton(
      onPressed: fun,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
        ),
      ));
}

Widget defaultFormField({
  context,
  required TextEditingController controller,
  required TextInputType type,
  required String msg,
  required double borderRadius,
  required bool isPassword,
  Function? onChanged,
  formkey,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Color? iconColor,
  required String label,
  Function? onTap,
  Function? onFieldSubmit,
}) {
  return TextFormField(
    controller: controller,
    key: formkey,
    validator: (String? value) {
      if (value!.isEmpty) {
        return msg;
      }
    },
    obscureText: isPassword,
    onChanged: (value) {
      onChanged;
    },
    onTap: () {
      onTap;
    },
    keyboardType: type,
    onFieldSubmitted: (value) {
      onFieldSubmit;
    },
    decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: iconColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            ShopLoginCubit.get(context).changeVisibility();
          },
          icon: Icon(
            suffixIcon,
            color: iconColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide())),
  );
}

void printFullText(String? text){
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text!).forEach((element)=> print(element.group(0)));
}


Widget signOut(context){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0)
    ),
    child: MaterialButton(
      minWidth: double.infinity,
        height: 55.0,
        onPressed: () {
          CacheHelper.removeData(key: "token");
          navigateAndFinish(widget: ShopLoginScreen(), context: context);
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ShopLoginScreen()), (route) => false);
        },
        child: const Text(
          "LOGOUT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      color: defaultColor,



    ),
  );
}

