import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../contents/utilities/failure.dart';
import '../model/car.dart';
import '../repository/car_repository.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final CarRepository _carRepository;

  CarsCubit(this._carRepository) : super(CarsInitial());

  void downloadCarOnwerFile() async {
    const url =
        'https://drive.google.com/file/d/1giBv3pK6qbOPo0Y02H-wjT9ULPksfBCm/view';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      emit(CarsError('Something went wrong with download. Please try again'));
    }
  }

  void filterCars({
    int startYear,
    int endYear,
    String gender,
    List<String> countries,
    List<String> colors,
  }) async {
    try {
      emit(CarsLoading());

      final cars = await _carRepository.getAllCars();

      final filteredCars = _carRepository.filterCars(cars,
          startYear: startYear,
          endYear: endYear,
          colors: colors,
          countries: countries,
          gender: gender);

      emit(CarsLoaded(filteredCars));
    } on Failure catch (f) {
      emit(CarsError(f.message));
    }
  }

  Future<void> getCars() async {
    try {
      emit(CarsLoading());
      final cars = await _carRepository.getAllCars();
      emit(CarsLoaded(cars));
    } on Failure catch (f) {
      emit(CarsError(f.message));
    }
  }
}
