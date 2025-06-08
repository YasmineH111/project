import 'dart:convert';

class MyTripModel {
  final int tripId;
  final int driverId;
  final Driver driver;
  final double oLatitude;
  final double oLongitude;
  final double dLatitude;
  final double dLongitude;
  final String date;
  final String time;
  final double price;
  final int seatsTotal;
  final int seatsBooked;
  final List<Seat> seats;

  MyTripModel({
    required this.tripId,
    required this.driverId,
    required this.driver,
    required this.oLatitude,
    required this.oLongitude,
    required this.dLatitude,
    required this.dLongitude,
    required this.date,
    required this.time,
    required this.price,
    required this.seatsTotal,
    required this.seatsBooked,
    required this.seats,
  });

  factory MyTripModel.fromJson(Map<String, dynamic> json) {
    return MyTripModel(
      tripId: json['tripId'],
      driverId: json['driverId'],
      driver: Driver.fromJson(json['driver']),
      oLatitude: (json['oLatitude'] as num).toDouble(),
      oLongitude: (json['oLongitude'] as num).toDouble(),
      dLatitude: (json['dLatitude'] as num).toDouble(),
      dLongitude: (json['dLongitude'] as num).toDouble(),
      date: json['date'].toString(),
      time: json['time'].toString(),
      price: (json['price'] as num).toDouble(),
      seatsTotal: json['seatsTotal'],
      seatsBooked: json['seatsBooked'],
      seats: (json['seats'] as List)
          .map((seatJson) => Seat.fromJson(seatJson))
          .toList(),
    );
  }
}

class Driver {
  final int driverId;
  final String email;
  final String name;
  final String mobileNumber;
  final String passwordHash;
  final String licenseNumber;

  Driver({
    required this.driverId,
    required this.email,
    required this.name,
    required this.mobileNumber,
    required this.passwordHash,
    required this.licenseNumber,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'],
      email: json['email'].toString(),
      name: json['name'].toString(),
      mobileNumber: json['mobileNumber'].toString(),
      passwordHash: json['passwordHash'].toString(),
      licenseNumber: json['licenseNumber'].toString(),
    );
  }
}

class Seat {
  final int seatId;
  final int tripId;
  final int seatNumber;
  final bool isAvailable;
  final String genderPreference;

  Seat({
    required this.seatId,
    required this.tripId,
    required this.seatNumber,
    required this.isAvailable,
    required this.genderPreference,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatId: json['seatId'],
      tripId: json['tripId'],
      seatNumber: json['seatNumber'],
      isAvailable: json['isAvailable'],
      genderPreference: json['genderPreference'].toString(),
    );
  }
}
