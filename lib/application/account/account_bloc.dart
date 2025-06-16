import 'package:bitecube/repositories/interfaces/account/i_account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'account_bloc.freezed.dart';

part 'account_event.dart';

part 'account_state.dart';

@Injectable()
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._accountRepository) : super(AccountState.initial()) {
    on<OnLogIn>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
          failure: null,
        ));

        final response = await _accountRepository.logIn(
          email: event.email,
          password: event.password,
        );

        response.fold(
          (left) {
            emit(
              state.copyWith(
                isLoading: false,
                failure: left,
              ),
            );
          },
          (right) {
            emit(
              state.copyWith(
                isLoading: false,
                email: event.email,
                name: right,
              ),
            );
          },
        );
      },
    );
    on<OnSignUp>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          failure: null,
        ),
      );

      final response = await _accountRepository.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      response.fold((left) {
        emit(state.copyWith(
          isLoading: false,
          failure: left,
        ));
      }, (right) {
        emit(
          state.copyWith(
            isLoading: false,
            name: event.name,
            email: event.email,
          ),
        );
      });
    });

    on<OnLogOut>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          failure: null,
        ),
      );

      final response = await _accountRepository.logOut();

      response.fold(
        (left) {
          emit(state.copyWith(
            isLoading: false,
            failure: left,
          ));
        },
        (right) {
          emit(AccountState.initial());
        },
      );
    });
  }

  final IAccountRepository _accountRepository;
}
