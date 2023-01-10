import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:swagapp/modules/api/api_service.dart';
import 'package:swagapp/modules/common/utils/context_service.dart';
import 'package:swagapp/modules/data/auth/i_auth_service.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../data/auth/auth_service.dart';
import '../data/shared_preferences/shared_preferences_service.dart';

final getIt = GetIt.instance;

const baseScope = 'baseScope';
const unauthorizedScope = 'unauthorizedScope';
const authorizedScope = 'authorizedScope';

Future<void> setupAppScope() {
  getIt.registerLazySingleton(() => PreferenceRepositoryService());
  getIt.registerLazySingleton(() => ContextService());
  getIt.registerLazySingleton<IAuthService>(() => AuthService(APIService()));
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt<IAuthService>()));
  return getIt.allReady();
}

Future<void> setupUnauthorizedScope(
  final GlobalKey<NavigatorState> rootNavigator,
) async {
  if (getIt.currentScopeName == unauthorizedScope) return;
  if (getIt.currentScopeName == authorizedScope) {
    await getIt.popScope();
    return;
  }
  getIt.pushNewScope(
    scopeName: unauthorizedScope,
    init: (getIt) {
      getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
        () => rootNavigator,
        instanceName: 'root_navigator',
      );
    },
  );
}

Future<void> setupAuthorizedScope(
  final GlobalKey<NavigatorState> rootNavigator,
  final GlobalKey<NavigatorState> homeNavigator,
) async {
  await setupUnauthorizedScope(rootNavigator);
  getIt.pushNewScope(
      scopeName: authorizedScope, init: (getIt) {}, dispose: () {});
}
