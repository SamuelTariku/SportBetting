import 'package:admin_abel/bet.dart';
import 'package:admin_abel/bloc/fixture_state.dart';
import 'package:admin_abel/repository/fixture_repository.dart';
import 'package:admin_abel/screens/adminBudgetMaintain.dart';
import 'package:flutter/material.dart';
import 'data_provider/fixture_data.dart';
import 'screens/adminUpdate.dart';
import 'screens/adminDetail.dart';
import 'screens/adminList.dart';
import 'screens/adminBudgetMaintain.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/fixture_bloc.dart';



void main() {
  final FixtureRepository fixtureRepository = FixtureRepository(
    dataProvider: FixtureDataProvider(
      httpClient: http.Client(),
    ),
  );
  final BetRepository betRepository = BetRepository(
    dataProvider: BetDataProvider(
      httpClient: http.Client(),
    ),
  );
  final BookieRepository bookieRepository = BookieRepository(
    dataProvider: BookieDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(
    MultiBlocProvider(providers: [BlocProvider<FixtureBloc>(
    create:(context)=> FixtureBloc(fixtureRepository: fixtureRepository)),
      BlocProvider<BookieBloc>(create: (context)=>BookieBloc(bookieRepository: bookieRepository)),
      BlocProvider<BetBloc>(create: (context)=>BetBloc(betRepository: betRepository))

  ],
      child: MyApp(fixtureRepository: fixtureRepository,bookieRepository: bookieRepository,)));
}


class MyApp extends StatelessWidget {
  final FixtureRepository fixtureRepository;
  final BookieRepository bookieRepository;
  MyApp({@required this.fixtureRepository,@required this.bookieRepository})
  : assert(fixtureRepository != null);

  @override
  Widget build(BuildContext context) {
    return
        MaterialApp(

          debugShowCheckedModeBanner: false,
          title: 'Admin Side',
          theme: ThemeData(

            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => AdminGameList(fixtureRepository: this.fixtureRepository),
            '/detail': (ctx) => AdminDetail(),
            '/update': (ctx) => AdminUpdate(bookieRepository: bookieRepository,),
            '/userList' : (ctx) => AdminBudgetMaintain(),
          },
    );

  }
}