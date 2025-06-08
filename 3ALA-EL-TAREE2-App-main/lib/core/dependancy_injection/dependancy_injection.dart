import 'package:cabify/Screens/driver/provider/add_trip_provider.dart';
import 'package:cabify/Screens/driver/screens/feed_back/provider/feed_back_provider.dart';
import 'package:cabify/Screens/driver/screens/my_trip/provider/my_trip_provider.dart';
import 'package:cabify/Screens/driver/screens/profile/provider/profile_provider.dart';
import 'package:cabify/Screens/user/screens/feed_back/provider/feed_back_provider.dart';
import 'package:cabify/Screens/user/screens/find_trip/provider/main_provider.dart';
import 'package:cabify/Screens/user/screens/map/provider/map_provider.dart';
import 'package:cabify/Screens/user/screens/my_seats/provider/my_seats_provider.dart';
import 'package:cabify/Screens/user/screens/pay_seat/provider/pay_seat_provider.dart';
import 'package:cabify/Screens/user/screens/profile/provider/profile_provider.dart';
import 'package:cabify/Screens/user/screens/seats/provider/seats_provider.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/services/api/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  locator.registerSingleton<CacheHelper>(cacheHelper);
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<DioConsumer>(
      () => DioConsumer(dio: locator<Dio>()));
  locator.registerFactory<AddTripProvider>(() => AddTripProvider());
  locator.registerFactory<SeatsProvider>(
    () => SeatsProvider(apiConsumer: locator<DioConsumer>()),
  );
  locator.registerFactory<MainProvider>(
    () => MainProvider(),
  );

  locator.registerFactory<ProfileProvider>(
    () => ProfileProvider(apiConsumer: locator<DioConsumer>()),
  );
  locator.registerFactory<MapProvider>(
    () => MapProvider(),
  );
  locator.registerFactory<FeedBackProvider>(
    () => FeedBackProvider(),
  );
  locator.registerFactory<MySeatsProvider>(
    () => MySeatsProvider(apiConsumer: locator<DioConsumer>()),
  );
  locator.registerFactory<DriverFeedBackProvider>(
    () => DriverFeedBackProvider(),
  );
  locator.registerFactory<DriverProfileProvider>(
    () => DriverProfileProvider(apiConsumer: locator<DioConsumer>()),
  );
  locator.registerFactory<MyTripsProvider>(
    () => MyTripsProvider(apiConsumer: locator<DioConsumer>()),
  );
  locator.registerFactory<PaySeatProvider>(
    () => PaySeatProvider(apiConsumer: locator<DioConsumer>()),
  );
}
