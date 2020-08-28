import 'package:get_it/get_it.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/services/cloud_firestore_service.dart';
import 'package:quiz_app/services/firebase_auth_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthenticationService());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => CloudFirestoreService());
}
