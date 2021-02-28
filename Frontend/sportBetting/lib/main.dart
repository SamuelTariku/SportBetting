import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  runApp(
    BetApp(
        betRepository: betRepository,
        gameRepo: fixtureRepository,
        bookieRepo: bookieRepository),
  );
}

class BetApp extends StatelessWidget {
  final BetRepository betRepository;
  final FixtureRepository gameRepo;
  final BookieRepository bookieRepo;

  BetApp(
      {@required this.betRepository,
      @required this.gameRepo,
      @required this.bookieRepo})
      : assert(betRepository != null && gameRepo != null && bookieRepo != null);

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) =>
                BetBloc(betRepository: this.betRepository)..add(BetLoad()),
          ),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  FixtureBloc(gameRepo: this.gameRepo)..add(FixtureLoad())),
          BlocProvider(
              lazy: false,
              create: (context) => BookieBloc(bookieRepository: this.bookieRepo)
                ..add(BookieBetLoad()))
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
