import 'package:admin_abel/bloc/fixture_event.dart';
import 'package:admin_abel/models/fixture.dart';
import 'package:admin_abel/repository/fixture_repository.dart';
import 'package:admin_abel/screens/addGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'adminBudgetList.dart';
import '../bloc/fixture_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_abel/bloc/fixture_state.dart';

class Game {
  String title;
  String subtitle;
  String time;//////
  Game({this.title, this.subtitle, this.time});
}

class AdminGameList extends StatelessWidget {

  final FixtureRepository fixtureRepository;

  AdminGameList({this.fixtureRepository});


  Card makeCard(int index, Function tap, List list) {
    List<Fixture> gameList=list;
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(45, 114, 178, 0.7).withOpacity(0.7)),
        child: makeListTile(index, tap,list),
      ),
    );
  }

  ListTile makeListTile(int index, Function tap,List list) {
    List<Fixture> gameList=list;
    String t1=gameList[index].teamOne;
    String t2=gameList[index].teamTwo;
    String title1='$t1 vs $t2';
    int num=index + 1;
    String title2='Match$num';

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

      title: Text(

      title1,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Text(title2, style: TextStyle(color: Colors.white))
        ],
      ),

      leading: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('images/betnow.jpeg'),
      ),
      onTap: tap,
    );
  }

  @override
  Widget build(BuildContext context) {
     List gameList;



     BlocProvider.of<FixtureBloc>(context).add(FixtureLoad());

      return Scaffold(
        appBar: AppBar(
          title: Text('Admin'),
          actions: <Widget>[
            FlatButton(
                child: Text("Budget", style: TextStyle(color: Colors.white),),
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AdminBudgetList()),
                );
                }
                )
          ]
        ),
        body: BlocBuilder<FixtureBloc, FixtureState>(
          builder: (context, state) {

            if (state is FixtureLoadSuccess) {
              final gameList = state.fix;
             // print('dhdbghdhhdhhfh ${state.fix}');
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: gameList.length,
                itemBuilder: (BuildContext context, int index) {
                  Function tap = () => Navigator.pushNamed(context, '/detail',
                      arguments: gameList[index]);
                  return makeCard(index, tap,gameList);
                },
              );
            }
            else{
              return Text("cannot get game list");
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddFixture()),);},
          tooltip: 'addGames',
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
    );
  }
}
