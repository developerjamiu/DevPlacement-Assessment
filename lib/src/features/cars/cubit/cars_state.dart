part of 'cars_cubit.dart';

@immutable
abstract class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

class CarsInitial extends CarsState {}

class CarsLoading extends CarsState {}

class CarsLoaded extends CarsState {
  const CarsLoaded(this.cars);

  final List<Car> cars;

  @override
  List<Object> get props => [cars];
}

class CarsError extends CarsState {
  const CarsError(this.message, {this.type});

  final String message;
  final int type;

  @override
  List<Object> get props => [message, type];
}
