import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../../../contents/utilities/external_storage.dart';
import '../../../contents/utilities/failure.dart';
import '../../../contents/utilities/num_utils.dart';
import '../../../contents/utilities/permission_handler.dart';
import '../../../contents/utilities/csv_file.dart';
import '../model/car.dart';

class CarRepository {
  final PermissionHandler _permissionHandler;
  final ExternalStorage _externalStorage;
  final CSVFile _csvFile;

  CarRepository(this._permissionHandler, this._externalStorage, this._csvFile);

  Future<List<Car>> getAllCars() async {
    List<Car> cars;

    try {
      var _status = await _permissionHandler.requestStoragePermission();

      if (_switchStatus(_status)) {
        final _appDocumentDirectory =
            await _externalStorage.getExternalStorageDirectory();

        final file = _csvFile.getFileFromPath(
            "$_appDocumentDirectory/owners/car_ownsers_data.csv");

        List<String> lines = _csvFile.readAsLinesSync(file);

        lines.removeAt(0);

        cars = <Car>[];
        for (var line in lines) cars.add(Car.fromList(line.split(',')));
      }

      return cars;
    } on FileSystemException {
      throw Failure(
        'The Car Onwers file cannot be found. Please download and save the csv in your file manager in a folder named owners',
        type: 0,
      );
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
    return filteredCars;
  }

  bool _switchStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        throw Failure('Storage permission is denied');
      case PermissionStatus.permanentlyDenied:
        throw Failure(
            'Storage permission has been denied permanently from your device');
      case PermissionStatus.restricted:
        throw Failure('Storage permission is restricted');
      case PermissionStatus.undetermined:
        throw Failure('Storage permission is undetermind');
      default:
        throw Failure('Something went wrong');
    }
  }
}
