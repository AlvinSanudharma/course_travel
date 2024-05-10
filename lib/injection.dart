import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:course_travel/core/platform/network_info.dart';
import 'package:course_travel/features/destination/data/datasource/destination_local_datasource.dart';
import 'package:course_travel/features/destination/data/datasource/destination_remote_datasource.dart';
import 'package:course_travel/features/destination/data/repositories/destination_repository_impl.dart';
import 'package:course_travel/features/destination/domain/repositories/destination_repository.dart';
import 'package:course_travel/features/destination/domain/usecases/get_all_destination_usecase.dart';
import 'package:course_travel/features/destination/domain/usecases/get_top_destination_usecase.dart';
import 'package:course_travel/features/destination/domain/usecases/search_destination_usecase%20copy.dart';
import 'package:course_travel/features/destination/presentation/bloc/all_destination/all_destination_bloc.dart';
import 'package:course_travel/features/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:course_travel/features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // NOTE: Bloc
  locator.registerFactory(() => AllDestinationBloc(locator()));
  locator.registerFactory(() => SearchDestinationBloc(locator()));
  locator.registerFactory(() => TopDestinationBloc(locator()));

  // NOTE: UseCase
  locator.registerLazySingleton(() => GetAllDestinationUsecase(locator()));
  locator.registerLazySingleton(() => GetTopDestinationUsecase(locator()));
  locator.registerLazySingleton(() => SearchDestinationUsecase(locator()));

  // NOTE: Repository
  locator.registerLazySingleton<DestinationRepository>(() =>
      DestinationRepositoryImpl(
          networkInfo: locator(),
          localDataSource: locator(),
          remoteDatasource: locator()));

  // NOTE: Datasource
  locator.registerLazySingleton<DestinationLocalDataSource>(
      () => DestinationLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<DestinationRemoteDatasource>(
      () => DestinationRemoteDatasourceImpl(locator()));

  // NOTE: Platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // NOTE: External
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => prefs);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
