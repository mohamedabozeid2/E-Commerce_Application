import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/home_page/cubit/cubit.dart';
import 'package:shop_app/modules/search_screen/cubit/cubit.dart';
import 'package:shop_app/modules/search_screen/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/styles/themes.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("SearchScreen"),
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          msg: 'Enter Text To Search',
                          borderRadius: 5.0,
                          isPassword: false,
                          prefixIcon: Icons.search,
                          label: "Search",
                          // onChanged: (value) {
                          //   SearchCubit.get(context).search(value);
                          // }
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: MaterialButton(
                            onPressed: () {
                              SearchCubit.get(context)
                                  .search(searchController.text);
                            },
                            height: 55.0,
                            minWidth: double.infinity,
                            color: defaultColor,
                            textColor: Colors.white,
                            child: const Text(
                              "Search",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // if(SearchCubit.get(context).model == null)
                        if (state is SearchLoadingStates)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchSuccessStates)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildListProduct(
                                  SearchCubit.get(context).model!,
                                  context,
                                  index);
                            },
                            separatorBuilder: (context, index) =>
                                myDividor(color: Colors.grey.shade300),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildListProduct(SearchModel? model, context, index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage(model!.data!.data![index].image!),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.data!.data![index].name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.0, height: 1.2),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.data!.data![index].price.toString(),
                        style: TextStyle(fontSize: 11.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context)
                                .changeFavorite(model.data!.data![index].id!, index);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopLayoutCubit.get(context)
                                    .favorites[model.data!.data![index].id]!
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
