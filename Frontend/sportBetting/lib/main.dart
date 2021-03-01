import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/data_provider/authentication_data.dart';
import 'package:flutter_network/bet/repository/user_repository.dart';
import 'package:flutter_network/bloc_observer.dart';
import 'package:flutter_network/bet/bet.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final BetRepository betRepository = BetRepository(
    dataProvider: BetDataProvider(
      httpClient: http.Client(),
    ),
  );

  final FixtureRepository fixtureRepository = FixtureRepository(
      dataProvider: FixtureDataProvider(httpClient: http.Client()));

  final BookieRepository bookieRepository = BookieRepository(
      dataProvider: BookieDataProvider(httpClient: http.Client()));

  final AuthenticationRepository authRepo = AuthenticationRepository(
      dataProvider: AuthenticationDataProvider(httpClient: http.Client()));

  final UserRepository userRepo =
      UserRepository(dataProvider: UserDataProvider(httpClient: http.Client()));

  runApp(
    BetApp(
      betRepository: betRepository,
      gameRepo: fixtureRepository,
      bookieRepo: bookieRepository,
      authRepo: authRepo,
      userRepo: userRepo,
    ),
  );
}

class BetApp extends StatelessWidget {
  final BetRepository betRepository;
  final FixtureRepository gameRepo;
  final BookieRepository bookieRepo;
  final AuthenticationRepository authRepo;
  final UserRepository userRepo;

  BetApp(
      {@required this.betRepository,
      @required this.gameRepo,
      @required this.bookieRepo,
      @required this.authRepo,
      @required this.userRepo})
      : assert(betRepository != null &&
            gameRepo != null &&
            bookieRepo != null &&
            authRepo != null &&
            userRepo != null);

  // @override
  // Widget build(BuildContext context) {
  //   return RepositoryProvider.value(
  //     value: this.betRepository,
  //     child: BlocProvider(
  //       create: (context) =>
  //           BetBloc(betRepository: this.betRepository)..add(BetLoad()),
  //       child: MaterialApp(
  //         title: 'Bet App',
  //         theme: ThemeData(
  //           primarySwatch: Colors.blue,
  //           visualDensity: VisualDensity.adaptivePlatformDensity,
  //         ),
  //         onGenerateRoute: BetAppRoute.generateRoute,
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBlo =
        AuthenticationBloc(authenticationRepository: this.authRepo)
          ..add(AppLoaded());

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => BetBloc(betRepository: this.betRepository)
              ..add(BetInitialize()),
          ),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  FixtureBloc(gameRepo: this.gameRepo)..add(FixtureLoad())),
          BlocProvider(
              lazy: false,
              create: (context) => BookieBloc(bookieRepository: this.bookieRepo)
                ..add(BookieBetLoad())),
          BlocProvider(lazy: false, create: (context) => authBlo),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  AuthenticationBloc(authenticationRepository: this.authRepo)
                    ..add(AppLoaded())),
          BlocProvider(
            lazy: false,
            create: (context) => UserBloc(userRepository: this.userRepo),
          ),
          BlocProvider(create: (context) => LoginBloc(authBlo, this.authRepo))
        ],
        child: MaterialApp(
          title: 'Bet App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: BetAppRoute.generateRoute,
        ));
  }
}
