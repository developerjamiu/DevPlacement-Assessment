import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  // Methods
  void onPageChanged(int value) {
    emit(value);
  }
}
