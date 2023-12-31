part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.walkthrough() = Walkthrough;
  const factory AuthState.onboarding() = Onboarding;
  const factory AuthState.logging() = Logging;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.error(final String message) = AuthenticationError;
  const factory AuthState.reset() = Reset;
  const factory AuthState.registered() = Registered;
  const factory AuthState.sendEmailSuccess() = SendEmail;
  factory AuthState.codeSent() = CodeStatus;
  factory AuthState.validCodeSuccess(ForgotPasswordCodeModel successValidCode) =
      LoadedvalidCodeSuccess;
}
