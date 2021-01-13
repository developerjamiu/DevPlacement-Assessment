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

  Car({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.carModel,
    this.carModelYear,
    this.carColor,
    this.gender,
    this.jobTitle,
    this.bio,
  });

  Car.fromList(List<String> items)
      : this(
          id: int.parse(items[0]),
          firstName: items[1],
          lastName: items[2],
          email: items[3],
          country: items[4],
          carModel: items[5],
          carModelYear: items[6],
          carColor: items[7],
          gender: items[8],
          jobTitle: items[9],
          bio: items[10],
        );

  @override
  String toString() {
    return 'Car{id: $id, firstName: $firstName, lastName: $lastName, email: $email, country: $country, carModel: $carModel, carModelYear: $carModelYear, carColor: $carColor, jobTitle: $jobTitle, gender: $gender, bio: $bio}';
  }
}
