import 'package:get_it/get_it.dart';
import 'package:upg_calculator/services/storage_service.dart';

GetIt locator = GetIt.instance;
setupServiceLocator() => locator.registerLazySingleton<StorageService>(() => StorageServiceSharedPref());
