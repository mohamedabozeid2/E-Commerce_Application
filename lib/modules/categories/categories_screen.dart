import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit , ShopLayoutStates>(
      listener: (context , state){

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (BuildContext context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return buildCatItem(ShopLayoutCubit.get(context).categoriesModel! , index);
              },
              separatorBuilder: (context, index) {
                return myDividor(
                    color: Colors.grey.shade300
                );
              },
              itemCount: ShopLayoutCubit.get(context).categoriesModel!.data!.data.length,
            );
          },
          fallback: (BuildContext context) => Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCatItem(CategoriesModel model, index){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(image: NetworkImage(
            "${model.data!.data[index].image}",
          ),width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            "${model.data!.data[index].name}",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
