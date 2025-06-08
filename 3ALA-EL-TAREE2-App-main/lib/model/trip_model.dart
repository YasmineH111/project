class TripModel {
  final int tripId;
  final int driverId;
  final Driver? driver; // Nullable
  final double? oLatitude; // Nullable
  final double? oLongitude; // Nullable
  final double? dLatitude; // Nullable
  final double? dLongitude; // Nullable
  final DateTime? date; // Nullable
  final String? time; // Nullable
  final double? price; // Nullable
  final int? seatsTotal; // Nullable
  final int? seatsBooked; // Nullable
  final List<Seat>? seats; // Nullable

  TripModel({
    required this.tripId,
    required this.driverId,
    this.driver,
    this.oLatitude,
    this.oLongitude,
    this.dLatitude,
    this.dLongitude,
    this.date,
    this.time,
    this.price,
    this.seatsTotal,
    this.seatsBooked,
    this.seats,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['tripId'] ?? 0,
      driverId: json['driverId'] ?? 0,
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      oLatitude: json['oLatitude'] != null
          ? (json['oLatitude'] as num).toDouble()
          : null,
      oLongitude: json['oLongitude'] != null
          ? (json['oLongitude'] as num).toDouble()
          : null,
      dLatitude: json['dLatitude'] != null
          ? (json['dLatitude'] as num).toDouble()
          : null,
      dLongitude: json['dLongitude'] != null
          ? (json['dLongitude'] as num).toDouble()
          : null,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      time: json['time'] ?? null,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      seatsTotal: json['seatsTotal'] ?? null,
      seatsBooked: json['seatsBooked'] ?? null,
      seats: json['seats'] != null
          ? (json['seats'] as List)
              .map((seatJson) => Seat.fromJson(seatJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'driverId': driverId,
      'driver': driver?.toJson(),
      'oLatitude': oLatitude,
      'oLongitude': oLongitude,
      'dLatitude': dLatitude,
      'dLongitude': dLongitude,
      'date': date?.toIso8601String(),
      'time': time,
      'price': price,
      'seatsTotal': seatsTotal,
      'seatsBooked': seatsBooked,
      'seats': seats?.map((seat) => seat.toJson()).toList(),
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'TripModel{tripId: $tripId, driverId: $driverId, driver: $driver, oLatitude: $oLatitude, oLongitude: $oLongitude, dLatitude: $dLatitude, dLongitude: $dLongitude, date: $date, time: $time, price: $price, seatsTotal: $seatsTotal, seatsBooked: $seatsBooked, seats: $seats}';
  }
}

class Driver {
  final int driverId;
  final String? email;
  final String? name;
  final String? mobileNumber;
  final String? passwordHash;
  final String? licenseNumber;

  Driver({
    required this.driverId,
    this.email,
    this.name,
    this.mobileNumber,
    this.passwordHash,
    this.licenseNumber,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'] ?? 0,
      email: json['email'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      passwordHash: json['passwordHash'],
      licenseNumber: json['licenseNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'email': email,
      'name': name,
      'mobileNumber': mobileNumber,
      'passwordHash': passwordHash,
      'licenseNumber': licenseNumber,
    };
  }
}

class Seat {
  final int seatId;
  final int tripId;
  final int seatNumber;
  final bool? isAvailable; // Nullable
  final String? genderPreference; // Nullable

  Seat({
    required this.seatId,
    required this.tripId,
    required this.seatNumber,
    this.isAvailable,
    this.genderPreference,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatId: json['seatId'] ?? 0,
      tripId: json['tripId'] ?? 0,
      seatNumber: json['seatNumber'] ?? 0,
      isAvailable: json['isAvailable'],
      genderPreference: json['genderPreference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatId': seatId,
      'tripId': tripId,
      'seatNumber': seatNumber,
      'isAvailable': isAvailable,
      'genderPreference': genderPreference,
    };
  }
}
