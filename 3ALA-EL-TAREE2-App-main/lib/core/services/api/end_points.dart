class EndPoints {
  static const String baseurl = 'http://ontheroad.somee.com/api/';
  static const String getTrip = 'Trip/GetAllTripsInLocation';
  static const String bookSeatEndPoint = 'Booking/BookASeat';
  static const String getUserProfile = 'Passenger/';
  static const String updateProfile = 'Passenger/';
  static const String getMySeats = 'Booking/getByPassenger/';
  static const String getDriverProfile = 'Driver/';
  static const String getMyTrips = 'Trip/GetTripsByDriverId/';
  static const String paySeat = 'Payment/add';
}

class ApiKeys {
  static String status = 'status';
  static String message = 'ErrorMessage';
  static String roleId = 'roleId';
  static String phone = 'phone';
  static String email = 'email';
  static String password = 'password';
  static String username = 'username';
  static String fullName = 'fullName';
}
