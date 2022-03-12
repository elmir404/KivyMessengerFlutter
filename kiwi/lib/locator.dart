import 'package:get_it/get_it.dart';
import 'package:kiwi/repository/user_repository.dart';
import 'package:kiwi/services/fake_auth_services.dart';
import 'package:kiwi/services/fireabase_auth_services.dart';
import 'package:kiwi/services/firestore_db_service.dart';
GetIt locator =GetIt.I;
void setubLocator(){
locator.registerLazySingleton(()=>FirebaseAuthService());
locator.registerLazySingleton(() => FakeAuthenticationService());
locator.registerLazySingleton(() => UserRepository());
locator.registerLazySingleton(() => FireStoreDbService());

}