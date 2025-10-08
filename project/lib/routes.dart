import 'package:go_router/go_router.dart';
import 'views/list_view.dart';
import 'views/detail_view.dart';
import 'models/joke.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const JokeListView(),
    ),
    GoRoute(
      name: 'detail',
      // id como parámetro de ruta requerido
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra;
        Joke? joke;
        if (extra != null && extra is Joke) {
          joke = extra;
        }
        return JokeDetailView(id: id, jokeFromExtra: joke);
      },
    ),
  ],
);
