import 'package:flutter_test/flutter_test.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/failure.dart';
import 'package:jamiu_okanlawon/src/features/cars/cubit/cars_cubit.dart';
import 'package:jamiu_okanlawon/src/features/cars/model/car.dart';
import 'package:jamiu_okanlawon/src/features/cars/repository/car_repository.dart';
import 'package:mockito/mockito.dart';

class MockCarRepository extends Mock implements CarRepository {}

void main() {
  CarRepository carRepository;
  CarsCubit carsCubit;

  setUp(() {
    carRepository = MockCarRepository();
    carsCubit = CarsCubit(carRepository);
  });

  group('Cars Cubit: Get Cars', () {
    test('Should emit CarsLoading and CarsLoaded when successful', () async {
      when(carRepository.getAllCars()).thenAnswer(
        (_) async => Future.value(<Car>[]),
      );

      final expected = <CarsState>[
        CarsLoading(),
        CarsLoaded(<Car>[]),
      ];

      expectLater(carsCubit, emitsInOrder(expected));

      carsCubit.getCars();
    });

    test('Should emit CarsLoading and CarsError when unsuccessful', () async {
      when(carRepository.getAllCars()).thenThrow(Failure('Fail'));

      final expected = <CarsState>[
        CarsLoading(),
        CarsError('Fail'),
      ];

      expectLater(carsCubit, emitsInOrder(expected));

      carsCubit.getCars();
    });
  });

  group('Cars Cubit: Filter Cars', () {
    test('Should emit CarsLoading and CarsLoaded when successful for Filter',
        () async {
      when(carRepository.getAllCars()).thenAnswer(
        (_) async => Future.value(<Car>[]),
      );

      when(carRepository.filterCars([])).thenReturn(<Car>[]);

      final expected = <CarsState>[
        CarsLoading(),
        CarsLoaded(<Car>[]),
      ];

      expectLater(carsCubit, emitsInOrder(expected));

      carsCubit.filterCars();
    });
  });
}
