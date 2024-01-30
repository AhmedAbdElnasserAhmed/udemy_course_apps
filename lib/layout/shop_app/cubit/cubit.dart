import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_dart/models/shop_app/categories_model.dart';
import 'package:udemy_flutter_dart/models/shop_app/change_favorites_model.dart';
import 'package:udemy_flutter_dart/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter_dart/models/shop_app/home_model.dart';
import 'package:udemy_flutter_dart/models/shop_app/login_model.dart';
import 'package:udemy_flutter_dart/modules/shop_app/categories/categories_screen.dart';
import 'package:udemy_flutter_dart/modules/shop_app/favorites/favorites_screen.dart';
import 'package:udemy_flutter_dart/modules/shop_app/products/products_screen.dart';
import 'package:udemy_flutter_dart/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:udemy_flutter_dart/shared/components/constants.dart';
import 'package:udemy_flutter_dart/shared/network/end_points.dart';
import 'package:udemy_flutter_dart/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // if (kDebugMode) {
      //   print(homeModel!.data.banners.toString());
      // }
      // if (kDebugMode) {
      //   print(homeModel!.data.banners[0].image);
      // }
      // if (kDebugMode) {
      //   print(homeModel!.status);
      // }
      // printFullText(homeModel.toString());

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: Get_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorCategoriesState(error: error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data:
      {
        'product_id': productId,
      },
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data.toString());

      if(!changeFavoritesModel!.status)
      {
        favorites[productId] = !favorites[productId]!;
      }else
      {
        getFavorites();
      }
        emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetFavoritesState(),);
    });
  }

  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.email);

      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      //throw(error);
      emit(ShopErrorUserDataState(),);
    });
  }


  void updateUserData({required String name, required String email, required String phone})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.email);

      emit(ShopSuccessUpdateUserState(userModel!));

    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      //throw(error);
      emit(ShopErrorUpdateUserState(),);
    });
  }
}
