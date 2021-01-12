import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../contents/utilities/failure.dart';
import '../model/car.dart';
import '../repository/car_repository.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final CarRepository _carRepository;

  CarsCubit(this._carRepository) : super(CarsInitial());

  Future<void> getCars() async {
    try {
      emit(CarsLoading());
      final weather = await _carRepository.getAllCars();
      emit(CarsLoaded(weather));
    } on Failure catch (f) {
      emit(CarsError(f.message));
    }
  }
}
