import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/coming_soon/presentation/bloc/coming_soon_bloc.dart';
import 'features/coming_soon/presentation/bloc/coming_soon_event.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_event.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.initDependencies();

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (_) => di.sl<DashboardBloc>()..add(const FetchDashboardDataEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => di.sl<SearchBloc>(),
        ),
        BlocProvider<ComingSoonBloc>(
          create: (_) => di.sl<ComingSoonBloc>()..add(const FetchComingSoonMoviesEvent()),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
      ),
    );
  }
}
