part of 'filtered_cars_cubit.dart';

class FilteredCarsState extends Equatable {
  const FilteredCarsState({
    this.startYear,
    this.endYear,
    this.gender,
    this.colors,
    this.countries,
    this.status,
  });

  final int startYear;
  final int endYear;
  final String gender;
  final List<String> colors;
  final List<String> countries;
  final Status status;

  FilteredCarsState copyWith({
    int startYear,
    int endYear,
    String gender,
    List<String> colors,
    List<String> countries,
    Status status,
  }) {
    return FilteredCarsState(
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      gender: gender ?? this.gender,
      colors: colors ?? this.colors,
      countries: countries ?? this.countries,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        startYear,
        endYear,
        gender,
        colors,
        countries,
        status,
      ];
}
