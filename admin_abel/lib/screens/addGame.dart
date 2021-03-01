import 'package:admin_abel/bloc/fixture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bet.dart';


class AddFixture extends StatefulWidget{
  static const routeName = 'fixtureAdd';
  @override
  _AddFixture createState() => _AddFixture();

}
class _AddFixture extends State<AddFixture> {
  final _formKey = GlobalKey<FormState>();
  final Map<String,dynamic> _fixture = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add the fixtures'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Team 1 name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter team';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["teamone"] = value;//endateresa
                  });
                },

              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Team 2 name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),

                ),
                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter team';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["teamtwo"] = value;
                  });
                },

              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Game time/date',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),

                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter date';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["date"] = value;
                  });
                },



              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Home team odds',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),

                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter odd one';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["team_one_odd"] = int.parse(value);
                  });
                },

              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Away team odds',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),

                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter odd two';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["team_two_odd"] = int.parse(value);
                  });
                },

              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Draw for team odds',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),

                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter for draw';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["draw_odd"] = int.parse(value);
                  });
                },

              ),
     
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'first team score odds',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),

                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter the odd ';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["team_one_score_first_odd"] = int.parse(value);
                  });
                },

              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Second team score odds',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),

                validator: (value) {
                  if(value.isEmpty){
                    return 'please enter odd';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this._fixture["team_two_score_first_odd"] = int.parse(value);
                  });
                },

              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                    onPressed: (){
                      final form = _formKey.currentState;
                      if(form.validate()){
                        form.save();
                        final FixtureEvent event = FixtureCreate(
                          Fixture(
                            teamOne: this._fixture["teamone"],
                            teamTwo: this._fixture["teamone"],
                            time: this._fixture["teamone"],
                            homeOdd: this._fixture["team_one_odd"],
                            awayOdd: this._fixture["team_two_odd"],
                            drawOdd: this._fixture["draw_odd"],
                            firstTeamOdd: this._fixture["team_one_score_first_odd"],
                            secondTeamOdd: this._fixture["team_two_score_first_odd"],
                          ),
                        );
                        BlocProvider.of<FixtureBloc>(context).add(event);
                            // navigation
                      }


                },
                    icon: Icon(Icons.save), label: Text('Add Game')),
              )






            ],
          ),
        )
      ),
    );

  }

}

// class AddGame extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Game"),
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Team 1"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Team 1 name',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   validator: (value) {
//                     if(value.isEmpty){
//                       return 'please enter team';
//                     }
//                     return null;
//                   },
//
//                 ),
//
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Team 2"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Team 2 name',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Game Time"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Game time/date',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Home win odd"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Home team odds',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Away win odd"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       hintText: 'Away team odds',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Draw odd"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       hintText: 'Draw odds',enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Home score first odd"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       hintText: 'Odds for home team scoring first',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Text("Away score first odd"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0, left: 8.0, right: 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       hintText: 'Odds for away team scoring first',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),),
//               ),
//               RaisedButton(
//                   child: Text("Add Game"),
//                   onPressed: (){
//                     //function to add game to rest and go back to adminList page
//                   }
//                   )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
