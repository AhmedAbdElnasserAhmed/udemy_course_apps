import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_dart/models/shop_app/categories_model.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget
{
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildCatItem(cubit.categoriesModel!.data.data[index]),
            separatorBuilder: (context , index) => myDivider(),
            itemCount: cubit.categoriesModel!.data.data.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCatItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: model?.image != null ? NetworkImage(
                model!.image,
              ) as ImageProvider : const AssetImage(
                'assets/images/error.jpg',
              ),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model!.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
