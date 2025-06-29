import 'package:fpdart/fpdart.dart';

abstract class IStoreRepository {
  Future<Either<Exception, List<Map<String, dynamic>>>> getMeals();
  Future<Either<Exception, String>> addMeal(Map<String, dynamic> meal);
  Future<Either<Exception, Unit>> setMeal(
    String id,
    Map<String, dynamic> meal,
  );
}
