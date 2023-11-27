import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/models/shop_app/login_model.dart';
import 'package:udemy_flutter_dart/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/network/end_points.dart';
import 'package:udemy_flutter_dart/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userRegister({required String name, required String email, required String password, required String phone})
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
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
        emit(ShopRegisterSuccessState(loginModel));
      }
    }).catchError(
        (error)
        {
          if (kDebugMode)
          {
            print(error.toString());
          }
          throw(error);
          emit(ShopRegisterErrorState(error.toString()));
        }
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
