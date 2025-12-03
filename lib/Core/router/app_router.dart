import 'package:go_router/go_router.dart';
import '../../features/todo/presentation/views/pages/home_page.dart';
import '../../features/todo/presentation/views/pages/detail_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: '한결`s Tasks'),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailPage(id: id);
          },
        ),
      ],
    ),
  ],
);
