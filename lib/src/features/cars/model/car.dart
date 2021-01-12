class Car {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String carModel;
  final String carModelYear;
  final String carColor;
  final String gender;
  final String jobTitle;
  final String bio;

  Car(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.carModel,
    this.carModelYear,
    this.carColor,
    this.jobTitle,
    this.gender,
    this.bio,
  );

  Car.fromList(List<String> items)
      : this(
          int.parse(items[0]),
          items[1],
          items[2],
          items[3],
          items[4],
          items[5],
          items[6],
          items[7],
          items[8],
          items[9],
          items[10],
        );

  @override
  String toString() {
    return 'FoodCrop{id: $id, firstName: $firstName, lastName: $lastName, email: $email, country: $country, carModel: $carModel, carModelYear: $carModelYear, carColor: $carColor, jobTitle: $jobTitle, gender: $gender, bio: $bio}';
  }
}
