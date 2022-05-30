import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/cubit/states.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: const Text("Shop"),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  )
              ),
            ],
          ),
          body: ShopLayoutCubit.get(context).bottomScreens[ShopLayoutCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: ShopLayoutCubit.get(context).bottomItems,
            currentIndex: ShopLayoutCubit.get(context).currentIndex,
            onTap: (value){
              ShopLayoutCubit.get(context).changeBotNav(value);
            },

          ),
        );
      },
    );
  }
}
