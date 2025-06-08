class DestenationModel {
  final String name;
  final String address;
  final String longitude;
  final String latitude;

  DestenationModel(
      {required this.name,
      required this.address,
      required this.longitude,
      required this.latitude});
  factory DestenationModel.fromJson(dynamic json) {
    return DestenationModel(
      name: (json["name"]).split(" ")[0],
      address: json["display_place"] ?? "",
      longitude: json['lon'].toString(),
      latitude: json['lat'].toString(),
    );
  }
  @override
  String toString() {
    return 'DestenationModel{name: $name, address: $address, longitude: $longitude, latitude: $latitude}';
  }
}
