import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:jamiu_okanlawon/src/features/cars/model/car.dart';
import 'package:jamiu_okanlawon/src/features/cars/repository/car_repository.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/permission_handler.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/external_storage.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/csv_file.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

class MockPermissionHandler extends Mock implements PermissionHandler {}

class MockExternalStorage extends Mock implements ExternalStorage {}

class MockCSVFile extends Mock implements CSVFile {
  @override
  File getFileFromPath(String filePath) => File(filePath);

  @override
  List<String> readAsLinesSync(File file) => ['A least One'];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PermissionHandler mockPermissionHandler;
  ExternalStorage mockExternalStorage;
  CSVFile mockCSVFile;
  CarRepository carRepository;

  setUp(() {
    mockPermissionHandler = MockPermissionHandler();
    mockExternalStorage = MockExternalStorage();
    mockCSVFile = MockCSVFile();
    carRepository =
        CarRepository(mockPermissionHandler, mockExternalStorage, mockCSVFile);
  });

  group('Car Repository: Get All Cars', () {
    test('Should return a list of cars when successful', () async {
      when(mockPermissionHandler.requestStoragePermission())
          .thenAnswer((_) => Future.value(PermissionStatus.granted));

      when(mockExternalStorage.getExternalStorageDirectory())
          .thenAnswer((_) => Future.value('/storage/emulated/0'));

      final cars = await carRepository.getAllCars();

      expect(cars, <Car>[]);
    });
  });
}
