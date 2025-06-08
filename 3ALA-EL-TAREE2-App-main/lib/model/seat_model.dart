class SeatModel {
  final int bookingId;
  final int passengerId;
  final Passenger passenger;
  final int tripId;
  final Trip trip;
  final int seatNumber;
  final DateTime bookingTime;

  SeatModel({
    required this.bookingId,
    required this.passengerId,
    required this.passenger,
    required this.tripId,
    required this.trip,
    required this.seatNumber,
    required this.bookingTime,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      bookingId: json['bookingId'],
      passengerId: json['passengerId'],
      passenger: Passenger.fromJson(json['passenger']),
      tripId: json['tripId'],
      trip: Trip.fromJson(json['trip']),
      seatNumber: json['seatNumber'],
      bookingTime: DateTime.parse(json['bookingTime']),
    );
  }
}

class Passenger {
  final int passengerId;
  final String email;
  final String name;
  final String mobileNumber;
  final String passwordHash;

  Passenger({
    required this.passengerId,
    required this.email,
    required this.name,
    required this.mobileNumber,
    required this.passwordHash,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passengerId: json['passengerId'],
      email: json['email'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      passwordHash: json['passwordHash'],
    );
  }
}

class Trip {
  final int tripId;
  final int driverId;
  final dynamic driver; // Replace with actual driver model if available
  final double oLatitude;
  final double oLongitude;
  final double dLatitude;
  final double dLongitude;
  final DateTime date;
  final String time;
  final double price;
  final int seatsTotal;
  final int seatsBooked;
  final dynamic seats; // Replace with actual seats model if available

  Trip({
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

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: json['tripId'],
      driverId: json['driverId'],
      driver: json['driver'],
      oLatitude: json['oLatitude'],
      oLongitude: json['oLongitude'],
      dLatitude: json['dLatitude'],
      dLongitude: json['dLongitude'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      price: (json['price'] as num).toDouble(),
      seatsTotal: json['seatsTotal'],
      seatsBooked: json['seatsBooked'],
      seats: json['seats'],
    );
  }
}
