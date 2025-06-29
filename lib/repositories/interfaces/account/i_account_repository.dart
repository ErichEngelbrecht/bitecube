import 'package:fpdart/fpdart.dart';

abstract class IAccountRepository {
  Future<Either<Exception, String>> logIn({
    required String email,
    required String password,
  });
  Future<Either<Exception, Unit>> logOut();
  Future<Either<Exception, String>> signUp({
    required String email,
    required String password,
    required String name,
  });
}
