// ignore_for_file: deprecated_member_use

import 'package:bitecube/repositories/interfaces/store/i_store_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStoreRepository)
class StoreRepository implements IStoreRepository {
  StoreRepository();

  @override
  Future<Either<Exception, List<Map<String, dynamic>>>> getMeals() async {
    try {
      final firebaseUID = FirebaseAuth.instance.currentUser?.uid ?? '';

      final meals = await FirebaseFirestore.instance
          .collection('/users/$firebaseUID/meals')
          .get();

      return right(meals.docs.map((document) => document.data()).toList());
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Unit>> setMeal(
    String id,
    Map<String, dynamic> meal,
  ) async {
    try {
      final firebaseUID = FirebaseAuth.instance.currentUser?.uid ?? '';
      await FirebaseFirestore.instance
          .collection('/users/$firebaseUID/meals')
          .doc(id)
          .set(meal);
      return right(unit);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, String>> addMeal(Map<String, dynamic> meal) async {
    try {
      final firebaseUID = FirebaseAuth.instance.currentUser?.uid ?? '';
      return right(
        (await FirebaseFirestore.instance
                .collection('/users/$firebaseUID/meals')
                .add(meal))
            .id,
      );
    } on Exception catch (e) {
      return left(e);
    }
  }
}
