class ProfileModel {
  final int? passengerId;
  final String email;
  final String name;
  final String mobileNumber;
  final String? passwordHash;

  ProfileModel(
      {this.passengerId,
      required this.email,
      required this.name,
      required this.mobileNumber,
      this.passwordHash});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      passengerId: json['passengerId'],
      email: json['email'],
      name: json['name'],
      mobileNumber: json['mobileNumber'].toString(),
      passwordHash: json['passwordHash'] ?? "",
    );
  }
  @override
  String toString() {
    return 'ProfileModel{passengerId: $passengerId, email: $email, name: $name, mobileNumber: $mobileNumber, passwordHash: $passwordHash}';
  }
}

// {
//   "passengerId": 1,
//   "email": "mokamel@example.com",
//   "name": "mokamel",
//   "mobileNumber": "123445",
//   "passwordHash": "AQAAAAIAAYagAAAAEH3ksoY5oRBnlNG840VKpKXYYmeu+qMXUr787VKtvr2i6mC2QgDiFrBzHuM397oXVQ=="
// }
