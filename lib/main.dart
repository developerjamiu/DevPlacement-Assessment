import 'package:flutter/material.dart';

import 'src/app_start/app.dart';
import 'src/features/cars/model/car.dart';
import 'src/features/cars/repository/car_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<Car> cars = await CarRepository().getAllCars();

  cars.forEach((car) {
    print(car.toString());
  });

  runApp(App());
}
