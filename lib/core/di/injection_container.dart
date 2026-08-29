import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../features/coming_soon/data/datasources/coming_soon_remote_data_source.dart';
import '../../features/coming_soon/data/repositories/coming_soon_repository.dart';
import '../../features/coming_soon/presentation/bloc/coming_soon_bloc.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/search/data/datasources/search_remote_data_source.dart';
import '../../features/search/data/repositories/search_repository.dart';
import '../../features/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // -------------------------------------------------------------
  // 1. Core & Network
  // -------------------------------------------------------------
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // -------------------------------------------------------------
  // 2. Data Sources
  // -------------------------------------------------------------
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<ComingSoonRemoteDataSource>(
    () => ComingSoonRemoteDataSourceImpl(apiClient: sl()),
  );

  // -------------------------------------------------------------
  // 3. Repositories
  // -------------------------------------------------------------
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ComingSoonRepository>(
    () => ComingSoonRepositoryImpl(remoteDataSource: sl()),
  );

  // -------------------------------------------------------------
  // 4. BLoCs / Cubits (Factory registration for fresh state per instance or screen lifecycle)
  // -------------------------------------------------------------
  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(repository: sl()),
  );
  sl.registerFactory<SearchBloc>(
    () => SearchBloc(repository: sl()),
  );
  sl.registerFactory<ComingSoonBloc>(
    () => ComingSoonBloc(repository: sl()),
  );
}
