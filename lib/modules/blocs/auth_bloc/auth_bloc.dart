import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/utils/handling_errors.dart';
import '../../common/utils/utils.dart';
import '../../constants/constants.dart';
import '../../data/auth/i_auth_service.dart';
import '../../data/secure_storage/storage_repository_service.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';
import '../../models/auth/create_account_payload_model.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService authService;
  late StreamSubscription<String?> _userStreamSubscription;

  AuthBloc(this.authService) : super(const AuthState.initial()) {
    _userStreamSubscription =
        authService.subscribeToAuthChanges().distinct().listen((user) async => {
              emit(getIt<PreferenceRepositoryService>().isLogged()
                  ? const AuthState.initial()
                  : const AuthState.unauthenticated()),
              if (getIt<PreferenceRepositoryService>().isLogged() &&
                  isTokenValid(
                      await getIt<StorageRepositoryService>().getToken()))
                {
                  add(AuthEvent.authenticate(
                      await getIt<StorageRepositoryService>().getEmail() ??
                          defaultString,
                      await getIt<StorageRepositoryService>().getPassword() ??
                          defaultString))
                }
            });

    // getIt<StorageRepositoryService>().saveToken("");
  }

  Stream<AuthState> get authStateStream async* {
    yield state;
    yield* stream;
  }

  void logout() => add(const AuthEvent.logout());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield* event.when(
      logout: _logout,
      authenticate: _authenticate,
      createAccount: _createAccount,
      init: _init,
    );
  }

  Stream<AuthState> _logout() async* {
    await authService.logOut();
    yield const AuthState.unauthenticated();
  }

  Stream<AuthState> _init() async* {
    yield const AuthState.initial();
  }

  Stream<AuthState> _createAccount(CreateAccountPayloadModel model) async* {
    yield const AuthState.logging();
    try {
      var response = await authService.createAccount(model);
      getIt<StorageRepositoryService>().saveToken(response.token);
      if (response.errorCode == successResponse) {
        yield const AuthState.authenticated();
      } else {
        yield AuthState.error(HandlingErrors().getError(response.errorCode));
      }
    } catch (e) {
      yield AuthState.error(HandlingErrors().getError(e));
    }
  }

  Stream<AuthState> _authenticate(String email, String password) async* {
    yield const AuthState.logging();
    try {
      var response = await authService.authenticate(email, password);
      getIt<StorageRepositoryService>().saveToken(response.token);
      if (response.errorCode == successResponse ||
          response.errorCode == defaultString) {
        yield const AuthState.authenticated();
      } else {
        yield AuthState.error(HandlingErrors().getError(response.errorCode));
      }
    } catch (e) {
      yield AuthState.error(HandlingErrors().getError(e));
    }
  }

  @override
  Future<void> close() async {
    await _userStreamSubscription.cancel();
    return super.close();
  }
}
