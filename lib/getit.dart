import 'package:get_it/get_it.dart';
import 'package:lamha/core/services/firebase_auth_services.dart';
import 'package:lamha/features/authintecation/data/repositories/user_repositry_Impl.dart';
import 'package:lamha/features/authintecation/domain/usecases/user_usecase.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  sl.registerLazySingleton(
    () => FirebaseAuthServices(),);
  sl.registerLazySingleton(
    () => UserRepositoryImpl(
       sl(),
  ));
  sl.registerLazySingleton(
    () => UserUsecase(
       userRepositry: sl(), 
  ));
  sl.registerLazySingleton(
    () => AuthintecationCubit(
       sl(),
    ),
  );
}