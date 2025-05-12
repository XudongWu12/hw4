import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hw/bloc/anthentication_bloc.dart';
import 'package:hw/go_router_refresh_stream.dart';
import 'package:hw/model/book.dart';
import 'package:hw/page/page.dart';
import 'package:hw/widget/scaffold_with_navbar.dart';


void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    // Create a Listenable from the AuthenticationBloc stream
    final authListenable = GoRouterRefreshStream(authBloc.stream);

    // Define the GoRouter with routes and redirection logic
    final router = GoRouter(
      refreshListenable: authListenable,
      redirect: (context, state) {
        final authState = authBloc.state;
        final isLoggedIn = authState is Authenticated;
        final isLoggingIn = state.matchedLocation == '/login';

        if (!isLoggedIn && !isLoggingIn) {
          return '/login';
        }
        if (isLoggedIn && isLoggingIn) {
          return '/byAuthor'; // Redirect to /byAuthor after login
        }
        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: [
            GoRoute(
              path: '/byAuthor',
              name: 'byAuthor',
              builder: (context, state) => const ByAuthorPage(),
              routes: [
                GoRoute(
                  path: 'detail',
                  name: 'byAuthorDetail',
                  builder: (context, state) {
                    final book = state.extra as Book;
                    return ByAuthorDetailPage(book: book);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/byTitle',
              name: 'byTitle',
              builder: (context, state) => const ByTitlePage(),
              routes: [
                GoRoute(
                  path: 'detail',
                  name: 'byTitleDetail',
                  builder: (context, state) {
                    final book = state.extra as Book;
                    return ByTitleDetailPage(book: book);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}