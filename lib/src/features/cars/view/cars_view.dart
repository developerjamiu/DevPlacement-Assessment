import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contents/constants/app_colors.dart';
import '../../../contents/constants/app_styles.dart';
import '../cubit/cars_cubit.dart';
import '../model/car.dart';

class CarsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarsCubit, CarsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final _cubit = context.watch<CarsCubit>();

        if (state is CarsError) {
          return buildErrorState(state.message, _cubit);
        } else if (state is CarsLoading) {
          return buildLoading();
        } else if (state is CarsLoaded) {
          return _CarsList(cars: state.cars);
        } else {
          return buildInitialInput();
        }
      },
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

  Widget buildErrorState(String message, CarsCubit cubit) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            size: 48,
            color: AppColors.errorColor,
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: AppStyles.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: cubit.downloadCarOnwerFile,
            child: Text('Download File'),
          ),
        ],
      ),
    );
  }
}

class _CarsList extends StatelessWidget {
  final List<Car> cars;

  const _CarsList({Key key, this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: imageByIndex(index),
          title: Text(cars[index].carModel),
          subtitle: Text(cars[index].carModelYear),
          trailing: IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                child: CarDetailDialog(car: cars[index]),
              );
            },
          ),
          contentPadding: const EdgeInsets.all(0),
        );
      },
    );
  }

  Widget imageByIndex(int index) {
    if (index % 3 == 0) {
      return Image.asset('assets/car_avatar.png');
    } else if (index % 3 == 1) {
      return Image.asset('assets/car_avatar2.png');
    } else {
      return Image.asset('assets/car_avatar3.png');
    }
  }
}

class CarDetailDialog extends StatelessWidget {
  final Car car;

  const CarDetailDialog({Key key, @required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              car.carModel,
              style: AppStyles.heading6,
            ),
            Divider(color: AppColors.accent, thickness: 2),
            SizedBox(height: 8),
            Text('Model: ${car.carColor}'),
            Text('Year: ${car.carModelYear}'),
            SizedBox(height: 16),
            Text('Onwer Info', style: AppStyles.bodyText1),
            Divider(color: AppColors.accent, thickness: 2),
            SizedBox(height: 8),
            Text('Name: ${car.firstName} ${car.lastName}'),
            Text('Gender: ${car.gender}'),
            Text('Email: ${car.email}'),
            Text('Occupation: ${car.jobTitle}'),
            Text('Country: ${car.country}'),
            Text('Bio ${car.bio}'),
          ],
        ),
      ),
    );
  }
}
