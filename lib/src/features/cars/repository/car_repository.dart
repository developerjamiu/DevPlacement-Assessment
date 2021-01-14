import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../contents/utilities/failure.dart';
import '../../../contents/utilities/num_utils.dart';
import '../model/car.dart';

class CarRepository {
  final Permission permission;

  CarRepository(this.permission);

  Future<List<Car>> getAllCars() async {
    try {
      var _status = await permission.status;
      if (!_status.isGranted) {
        await permission.request();
      }

      final _appDocumentDirectory =
          await ExtStorage.getExternalStorageDirectory();
      print("$_appDocumentDirectory/owners/car_ownsers_data.csv");
      final file = File("$_appDocumentDirectory/owners/car_ownsers_data.csv");

      List<String> lines = file.readAsLinesSync();

      lines.removeAt(0);

      var cars = <Car>[];
      for (var line in lines) cars.add(Car.fromList(line.split(',')));

      return cars;
    } on FileSystemException {
      throw Failure(
          'The Car Onwers file cannot be found. Please download and save the csv in your file manager in a folder named owners');
    }
  }

  List<Car> filterCars(
    List<Car> cars, {
    int startYear,
    int endYear,
    String gender,
    List<String> countries,
    List<String> colors,
  }) {
    try {
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
              (colors == null ||
                  colors.isEmpty ||
                  colors.contains(car.carColor));
          if (dateCondition) filteredCars.add(car);
        }
      });
      return filteredCars;
    } catch (ex) {
      throw Failure(ex.toString());
    }
  }
}
