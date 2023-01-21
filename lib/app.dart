import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swagapp/modules/pages/login/landing_page.dart';
import 'package:swagapp/modules/blocs/search_bloc.dart/search_bloc.dart';
import 'generated/l10n.dart';

import 'modules/blocs/auth_bloc/auth_bloc.dart';
import 'modules/blocs/detail_bloc/detail_bloc.dart';
import 'modules/blocs/explore_bloc/explore_bloc.dart';
import 'modules/blocs/favorite_bloc/favorite_bloc.dart';
import 'modules/pages/home/home_page.dart';
import 'modules/common/utils/context_service.dart';
import 'modules/common/utils/palette.dart';
import 'modules/common/utils/theme.dart';
import 'modules/di/injector.dart';
import 'modules/pages/splash/splash_page.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'home_page_tab',
  );

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
          // BlocProvider<SignUpBloc>(create: (_) => getIt<SignUpBloc>()),
          BlocProvider<SearchBloc>(create: (context) => getIt<SearchBloc>()),
          BlocProvider<ExploreBloc>(create: (context) => getIt<ExploreBloc>()),
          BlocProvider<DetailBloc>(create: (context) => getIt<DetailBloc>()),
          BlocProvider<FavoriteBloc>(
              create: (context) => getIt<FavoriteBloc>()),
        ],
        child: MaterialApp(
          navigatorKey: getIt<ContextService>().rootNavigatorKey,
          debugShowCheckedModeBanner: false,
          theme: appTheme(LightPalette()),
          title: 'Swag Golf',
          supportedLocales: const [
            Locale('en', ''),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate
          ],
          home: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) => state.maybeMap(
                initial: (_) => const SplashPage(),
                authenticated: (_) => const HomePage(),
                walkthrough: (_) => const LandingPage(),
                onboarding: (_) => const LandingPage(),
                orElse: () => const LandingPage(),
                unauthenticated: (_) {
                  return const LandingPage();
                }),
            listener: (context, state) => state.maybeMap(
                // orElse: () => null,
                orElse: () async {
              await setupUnauthorizedScope(
                  getIt<ContextService>().rootNavigatorKey);
              return null;
            }, authenticated: (_) async {
              await setupAuthorizedScope(
                  getIt<ContextService>().rootNavigatorKey, _homeNavigatorKey);
              return null;
            }),
          ),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) => authState.maybeMap(
                  orElse: () => child!,
                  unauthenticated: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider<AuthBloc>(
                            create: (context) => getIt<AuthBloc>(),
                          ),
                        ],
                        child: child!,
                      ),
                  authenticated: (_) => RepositoryProvider.value(
                        value: _homeNavigatorKey,
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider<AuthBloc>(
                              create: (context) => getIt<AuthBloc>(),
                            ),
                          ],
                          child: child!,
                        ),
                      )),
            ),
          ),
        ));
  }
}
