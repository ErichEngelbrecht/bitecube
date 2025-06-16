import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/extensions/date_time.dart';
import 'package:bitecube/repositories/interfaces/store/i_store_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'store_bloc.freezed.dart';

part 'store_event.dart';

part 'store_state.dart';

@Injectable()
class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(this._storeRepository) : super(StoreState.initial()) {
    on<GetMeals>(
      (event, emit) async {
        emit(
          state.copyWith(
            isLoading: true,
          ),
        );

        // TODO: Comment following code to enable Online Mode
        final response = right(
          [
            MealDTO(
              id: 1234,
              mealType: 'breakfast',
              mealTitle: 'Toast Broodjie',
              mealDescription:
                  'n Baie lekker broodjie met so paar smere botter',
              quantity: 2,
              unixTime: DateTime(2025, 6, 15, 10, 14).toUnixTime(),
              calories: 560,
              protein: 47,
              carbohydrates: 140,
              fats: 15,
            ).toJson(),
            MealDTO(
              id: 1235,
              mealType: 'lunch',
              mealTitle: 'Toast Broodjie',
              mealDescription:
                  'n Baie lekker broodjie met so paar smere botter',
              quantity: 2,
              unixTime: DateTime(2025, 6, 16, 14, 37).toUnixTime(),
              calories: 680,
              protein: 52,
              carbohydrates: 162,
              fats: 12,
            ).toJson(),
            MealDTO(
              id: 1234,
              mealType: 'lunch',
              mealTitle: 'Toast Broodjie',
              mealDescription:
                  'n Baie lekker broodjie met so paar smere botter',
              quantity: 2,
              unixTime: DateTime(2025, 6, 13, 10, 14).toUnixTime(),
              calories: 322,
              protein: 10,
              carbohydrates: 70,
              fats: 9,
            ).toJson(),
            MealDTO(
              id: 1235,
              mealType: 'lunch',
              mealTitle: 'Toast Broodjie',
              mealDescription:
                  'n Baie lekker broodjie met so paar smere botter',
              quantity: 2,
              unixTime: DateTime(2025, 6, 5, 14, 37).toUnixTime(),
              calories: 430,
              protein: 8,
              carbohydrates: 50,
              fats: 3,
            ).toJson(),
          ],
        );

        // TODO: Uncomment code to run repository calls (Online mode)
        // final response = await _storeRepository.getMeals();

        response.fold(
          (left) {
            emit(
              state.copyWith(
                failure: left,
                isLoading: false,
              ),
            );
          },
          (right) {
            emit(
              state.copyWith(
                meals: right.map(MealDTO.fromJson).toList(),
                isLoading: false,
              ),
            );
          },
        );
      },
    );
    on<SetMeal>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));

        final response = right(unit);

        //TODO: Uncomment code to send meal to Firestore (Online mode)
        // final response = await _storeRepository.setMeal(
        //   event.meal.id.toString(),
        //   event.meal.toJson(),
        // );

        response.fold((left) {
          emit(
            state.copyWith(
              isLoading: false,
              failure: left,
            ),
          );
        }, (right) {
          final editingMeal = state.meals.any(
            (oldMeal) => oldMeal.id == event.meal.id,
          );

          var mealsCopy = [...state.meals];

          if (editingMeal) {
            mealsCopy.removeWhere(
              (meal) => meal.id == event.meal.id,
            );
          }

          emit(
            state.copyWith(
              meals: [...mealsCopy, event.meal],
              isLoading: false,
            ),
          );
        });
      },
    );
    on<OnChangeDate>((event, emit) {
      emit(state.copyWith(
        date: event.date,
      ));
    });
  }

  final IStoreRepository _storeRepository;
}
