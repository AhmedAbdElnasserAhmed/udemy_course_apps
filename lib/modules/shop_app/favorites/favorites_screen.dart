import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_dart/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget
{
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.favorites.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildShopListProduct(cubit.favoritesModel!.data!.data![index].product!, context),
            separatorBuilder: (context , index) => myDivider(),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  // Widget buildFavItem(model , cubit) => Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: SizedBox(
  //           height: 120.0,
  //           //width: double.infinity,
  //           child: Row(
  //             children: [
  //               Stack(
  //                 alignment: AlignmentDirectional.bottomStart,
  //                 children: [
  //                   Image(
  //                     image: model.image != null ? NetworkImage(
  //                       '${model.image}',
  //                     ) : const NetworkImage(
  //                         'https://mf.b37mrtl.ru/media/pics/2023.05/original/6474ab494c59b7455d17922b.jpg'),
  //                     height: 120.0,
  //                     width: 120.0,
  //                   ),
  //                     if (model.discount != 0)
  //                     Container(
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 5.0,
  //                       ),
  //                       color: Colors.red,
  //                       child: const Text(
  //                         'DISCOUNT',
  //                         style: TextStyle(
  //                           fontSize: 8.0,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 width: 20.0,
  //               ),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       '${model.name}',
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: const TextStyle(
  //                         fontSize: 14.0,
  //                         height: 1.3,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 5.0,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Text(
  //                           '${model.price.round()}',
  //                           style: const TextStyle(
  //                             fontSize: 12.0,
  //                             color: defaultColor,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 5.0,
  //                         ),
  //                         if (model.discount != 0)
  //                           Text(
  //                             '${model.oldPrice.round()}',
  //                             style: const TextStyle(
  //                               fontSize: 10.0,
  //                               color: Colors.grey,
  //                               decoration: TextDecoration.lineThrough,
  //                             ),
  //                           ),
  //                         const Spacer(),
  //                         CircleAvatar(
  //                           radius: 15.0,
  //                           backgroundColor: cubit.favorites[model.id]
  //                               ? defaultColor
  //                               : Colors.grey,
  //                           child: IconButton(
  //                             onPressed: ()
  //                             {
  //                               cubit.changeFavorites(model.id);
  //                             },
  //                             icon: const Icon(
  //                               Icons.favorite_outline,
  //                               size: 14.0,
  //                               color: Colors.white,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
}
