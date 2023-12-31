import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/models/shop_app/search_model.dart';
import 'package:udemy_flutter_dart/modules/shop_app/search/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/components/constants.dart';
import 'package:udemy_flutter_dart/shared/network/end_points.dart';
import 'package:udemy_flutter_dart/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data:
      {
        'text' : text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SearchErrorState());
    });
  }
}
