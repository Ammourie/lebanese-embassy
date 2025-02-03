import 'package:get_it/get_it.dart';

import 'core/state/appstate.dart';
import 'core/utils/network_info.dart';
import 'features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'features/account/data/repositories/account_repository.dart';
import 'features/account/domain/use_cases/login_use_case.dart';
import 'features/account/presentation/blocs/account_bloc.dart';
import 'features/category/data/remote/data_sources/category_remote_data_source.dart';
import 'features/category/data/repositories/category_repository.dart';
import 'features/category/domain/use_cases/get_category_use_case.dart';
import 'features/category/presentation/blocs/category_bloc.dart';
import 'features/notification/data/remote/data_sources/notification_remote_data_source.dart';
import 'features/notification/data/repositories/notification_repository.dart';
import 'features/notification/domain/use_cases/get_notification_use_case.dart';
import 'features/notification/presentation/blocs/notification_bloc.dart';
import 'features/order/data/remote/data_sources/order_remote_data_source.dart';
import 'features/order/data/repositories/order_repository.dart';
import 'features/order/presentation/blocs/order_bloc.dart';
import 'features/services/data/remote/data_sources/service_remote_data_source.dart';
import 'features/services/data/repositories/service_repository.dart';
import 'features/services/domain/use_cases/get_service_use_case.dart';
import 'features/services/presentation/blocs/service_bloc.dart';



final sl = GetIt.instance;

Future<void> init(prefs) async {



  sl.registerLazySingleton(() => AccountBloc());
  sl.registerLazySingleton(() => ServiceBloc());
  sl.registerLazySingleton(() => CategoryBloc());
  sl.registerLazySingleton(() => OrderBloc());
  sl.registerLazySingleton(() => NotificationBloc() );

  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => AppStateModel(prefs));


  // Data sources

  sl.registerLazySingleton(() => AccountRemoteDataSource());
  sl.registerLazySingleton(() => ServiceRemoteDataSource());
  sl.registerLazySingleton(() => CategoryRemoteDataSource());
  sl.registerLazySingleton(() => OrderRemoteDataSource());
  sl.registerLazySingleton(() => NotificationRemoteDataSource());


  // Repositories
   sl.registerLazySingleton(() => AccountRepository(sl()));
   sl.registerLazySingleton(() => ServiceRepository(sl()));
   sl.registerLazySingleton(() => OrderRepository(sl()));
   sl.registerLazySingleton(() => CategoryRepository(sl()));
   sl.registerLazySingleton(() => NotificationRepository(sl()));


  // Usecases

  sl.registerLazySingleton(() => LogInUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetServiceUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificationUseCase(sl()));
}
