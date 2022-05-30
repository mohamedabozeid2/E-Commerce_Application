import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/home_page/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/styles/themes.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildFavItem(
                  ShopLayoutCubit.get(context)
                      .favoriteModel!
                      .data!
                      .data![index],
                  context,
                  index
              );
            },
            separatorBuilder: (context, index) =>
                myDividor(color: Colors.grey.shade300),
            itemCount: ShopLayoutCubit.get(context)
                .favoriteModel!
                .data!
                .data!
                .length),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
          condition: ShopLayoutCubit.get(context).favoriteModel != null,
        );
      },
    );
  }

  Widget buildFavItem(FavoriteData? model, context, index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.product!.image!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "discount".toUpperCase(),
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.0, height: 1.2),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product!.price.toString(),
                        style: TextStyle(fontSize: 11.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(model.product!.oldPrice.toString(),
                            style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context).changeFavorite(model.product!.id!, index);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopLayoutCubit.get(context)
                                    .favorites[model.product!.id]!
                                ? defaultColor
                                : Colors.grey,
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
      ),
    );
  }
}
