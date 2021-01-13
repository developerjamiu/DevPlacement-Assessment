import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meta/meta.dart';

import '../../../contents/utilities/failure.dart';
import '../../../contents/utilities/num_utils.dart';
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
    emit(CarsLoading());
    final cars = await _carRepository.getAllCars();
    List<Car> filteredCars = [];

    cars.forEach((car) {
      if (NumUtils.isNumericUsingTryParse(car.carModelYear)) {
        int year = int.parse(car.carModelYear);

        bool dateCondition = (startYear == null || year >= startYear) &&
            (endYear == null || year <= endYear) &&
            (gender == null || gender == car.gender) &&
            (countries == null ||
                countries.isEmpty ||
                countries.contains(car.country)) &&
            (colors == null || colors.isEmpty || colors.contains(car.carColor));
        if (dateCondition) filteredCars.add(car);
      }
    });
    print(filteredCars.length);
    emit(CarsLoaded(filteredCars));
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
