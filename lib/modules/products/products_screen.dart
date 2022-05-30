import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/styles/themes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavoriteState){
          if(!state.model.status!){
            showToast(msg: state.model.message!);
          }else{
            if(ShopLayoutCubit.get(context).favorites[ShopLayoutCubit.get(context).homeModel!.data!.products[state.index].id]!){
              showToast(msg: "Added Successfully To Favorite");
            }else{
              showToast(msg: "Removed Successfully From Favorite");
            }
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null && ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (context) {
            return productBuilder(ShopLayoutCubit.get(context).homeModel, ShopLayoutCubit.get(context).categoriesModel!, context);
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners.map((element) {
                return Image(
                  image: NetworkImage('${element.image}'),
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                autoPlay: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => myDividor(color: Colors.grey),
                      itemCount: categoriesModel.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  "New Products",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(model.data!.products.length, (index) {
                  return buildGridProduct(model, index, context);
                })),
          )
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
              "${model.image}"),
          width: 100.0,
          height: 100.0,

        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            "${model.name}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget buildGridProduct(HomeModel? model, index, context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.data!.products[index].image!),
                width: double.infinity,
                height: 200,
              ),
              if (model.data!.products[index].discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Discount",
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.data!.products[index].name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13.0, height: 1.2),
                ),
                Row(
                  children: [
                    Text(
                      "${model.data!.products[index].price!.round()}",
                      style: TextStyle(fontSize: 11.0, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.data!.products[index].discount != 0)
                      Text("${model.data!.products[index].oldPrice!.round()}",
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavorite(model.data!.products[index].id!, index);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopLayoutCubit.get(context).favorites[model.data!.products[index].id]! ? defaultColor : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
