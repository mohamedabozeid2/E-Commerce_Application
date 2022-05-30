import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/home_page/home_screen.dart';
import 'package:shop_app/shared/bloc_observer/bloc_observer.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/styles/themes.dart';
import 'modules/OnBoard/onboard.dart';
import 'modules/home_page/cubit/cubit.dart';
import 'modules/home_page/cubit/states.dart';

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget? startWidget;
  print("onBoarding = $onBoarding");
  if (CacheHelper.getData(key: "onBoarding") != null) {
    onBoarding = CacheHelper.getData(key: "onBoarding");
  }
  print("onBoarding = $onBoarding");
  token = CacheHelper.getData(key: "token");
  // print(token);

  if (onBoarding != false) {
    if (token != null) {
      startWidget = ShopLayout();
    } else {
      startWidget = ShopLoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        onBoarding: onBoarding,
        startWidget: startWidget!,
      ));
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;

  MyApp({
    required this.onBoarding,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopLayoutCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoriteData()
              ..getUserData()),
        // BlocProvider(
        //     create: (context) => SearchCubit()
        // )
      ],
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
