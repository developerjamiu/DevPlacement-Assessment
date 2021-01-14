import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/status.dart';
import 'package:jamiu_okanlawon/src/features/cars/cubit/cars_cubit.dart';
import 'package:jamiu_okanlawon/src/features/cars/cubit/filtered_cars_cubit.dart';
import 'package:mockito/mockito.dart';

class MockCarsCubit extends Mock implements CarsCubit {}

void main() {
  CarsCubit carsCubit;
  FilteredCarsCubit filteredCarsCubit;

  setUp(() {
    carsCubit = MockCarsCubit();
    filteredCarsCubit = FilteredCarsCubit(carsCubit);
  });

  group('Filtered Cars Cubit: Filter Cars', () {
    test(
        'Should emit Status.loading, Status.back and Status.initial when successful',
        () async {
      when(carsCubit.filterCars()).thenReturn(Void);

      final expected = <FilteredCarsState>[
        FilteredCarsState(status: Status.loading),
        FilteredCarsState(status: Status.back),
        FilteredCarsState(status: Status.initial),
      ];

      expectLater(filteredCarsCubit, emitsInOrder(expected));

      filteredCarsCubit.filterCars();
    });
  });
}
