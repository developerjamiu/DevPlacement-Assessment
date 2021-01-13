import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'filtered_cars_state.dart';

class FilteredCarsCubit extends Cubit<FilteredCarsState> {
  FilteredCarsCubit() : super(const FilteredCarsState());

  // Local Variables
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();

  // Getter
  TextEditingController get startYearController => _startYearController;
  TextEditingController get endYearController => _endYearController;

  // Methods
  void startYearChanged(String value) {
    int startYear = int.parse(value);
    emit(state.copyWith(startYear: startYear));
  }

  void endYearChanged(String value) {
    int endYear = int.parse(value);
    emit(state.copyWith(endYear: endYear));
  }

  void genderChanged(String value) {
    emit(state.copyWith(gender: value));
  }

  void colorsChanged(List<String> value) {
    emit(state.copyWith(colors: value));
  }

  void countriesChanged(List<String> value) {
    emit(state.copyWith(countries: value));
  }

  void resetStates() {
    _startYearController.text = '';
    _endYearController.text = '';
    emit(FilteredCarsState());
  }

  // Future<void> logIn() async {
  //   if (!_formKey.currentState.validate()) return;
  //   emit(state.copyWith(status: AuthStatus.submissionInProgress));
  //   try {
  //     await Future.delayed(Duration(seconds: 3));
  //     emit(state.copyWith(status: AuthStatus.submissionSuccess));
  //   } on Exception {
  //     emit(state.copyWith(status: AuthStatus.submissionFailure));
  //   }
  // }
}
