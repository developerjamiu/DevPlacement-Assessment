import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../contents/utilities/status.dart';

import 'cars_cubit.dart';

part 'filtered_cars_state.dart';

class FilteredCarsCubit extends Cubit<FilteredCarsState> {
  FilteredCarsCubit(this.carsCubit) : super(const FilteredCarsState());

  final CarsCubit carsCubit;

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

  void filterCars() async {
    emit(state.copyWith(status: Status.loading));

    carsCubit.filterCars(
      startYear: state.startYear,
      endYear: state.endYear,
      colors: state.colors,
      countries: state.countries,
      gender: state.gender == 'All' ? null : state.gender,
    );

    emit(state.copyWith(status: Status.back));
    emit(state.copyWith(status: Status.initial));
  }
}
