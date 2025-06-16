// ignore_for_file: deprecated_member_use

import 'package:bitecube/repositories/interfaces/account/i_account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAccountRepository)
class AccountRepository implements IAccountRepository {
  AccountRepository();

  @override
  Future<Either<Exception, String>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredentials.user?.displayName ?? '');
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, String>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredentials.user?.updateDisplayName(name);
      return right(userCredentials.user?.uid ?? '');
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Unit>> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return right(unit);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
