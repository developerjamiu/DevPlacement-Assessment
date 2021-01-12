import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cars_cubit.dart';
import '../model/car.dart';
import '../repository/car_repository.dart';

class CarsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarsCubit(CarRepository())..getCars(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cars'),
        ),
        body: BlocConsumer<CarsCubit, CarsState>(
          listener: (context, state) {
            if (state is CarsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CarsInitial) {
              return buildInitialInput();
            } else if (state is CarsLoading) {
              return buildLoading();
            } else if (state is CarsLoaded) {
              return _CarsList(cars: state.cars);
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Container();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _CarsList extends StatelessWidget {
  final List<Car> cars;

  const _CarsList({Key key, this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cars[index].carModel),
          subtitle: Text(cars[index].carModelYear),
        );
      },
    );
  }
}
