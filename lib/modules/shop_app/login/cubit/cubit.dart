import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/models/shop_app/login_model.dart';
import 'package:udemy_flutter_dart/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/network/end_points.dart';
import 'package:udemy_flutter_dart/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({required String email , required String password,})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email' : email,
        'password' : password,
      },
    ).then((value)
    {
      if (kDebugMode)
      {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        // print(loginModel.status);
        // print(loginModel.message);
        // print(loginModel.data?.token
        // );
        emit(ShopLoginSuccessState(loginModel));
      }
    }).catchError(
        (error)
        {
          if (kDebugMode)
          {
            print(error.toString());
          }
          emit(ShopLoginErrorState(error.toString()));
        }
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
