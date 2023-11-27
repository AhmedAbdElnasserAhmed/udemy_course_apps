import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/modules/counter_app/counter/cubit/states.dart';


class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterInitialState());

  // to be more easily when use this cubit in many places
  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus ()
  {
    counter--;
    emit(CounterMinusState(counter));
  }

  void plus ()
  {
    counter++;
    emit(CounterPlusState(counter));
  }
}