import 'package:admin_abel/bet.dart';
import 'package:admin_abel/bloc/bookie_bloc.dart';
import 'package:admin_abel/models/bookie.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'adminList.dart';
import 'adminDetail.dart';
import '../models/fixture.dart' as fixture;

enum teamchoice { manutd, mancity }

class AdminUpdate extends StatefulWidget {
  BookieRepository bookieRepository;
  AdminUpdate({this.bookieRepository});
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<AdminUpdate> {
  bool ShowElement1 = false;
  bool ShowElement2 = false;
  int svalue;
  int svalue2;


  winChooser() {
    setState(() {
      ShowElement1 = true;
      ShowElement2 = false;
    });
  }

  firstChooser() {
    setState(() {
      ShowElement1 = false;
      ShowElement2 = true;
    });
  }

  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  Bookie ubookie;
  bool builderFlag=false;
  @override
  Widget build(BuildContext context) {
    final Fixture game = ModalRoute.of(context).settings.arguments;

    String str1=game.teamOne;
    String str;
    String str3;
    String str2=game.teamTwo;
    List<Bookie> bookies;

    List<int> vals;
    return Scaffold(
      key: skey,
      appBar: AppBar(title: Text('Update')),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RaisedButton(onPressed: winChooser, child: Text('Choose  teams')),
              AnimatedOpacity(
                opacity: ShowElement1 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Container(
                      child: Text('The team that Won the game:'),
                      margin: EdgeInsets.only(top: 40, bottom: 40),
                    ),
                    ListTile(
                      title: Text(str1),
                      leading: Radio(
                        value: 1,
                        groupValue: svalue,
                        onChanged: (int value) {
                          setState(() {
                            svalue = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(str2),
                      leading: Radio(
                        value: 2,
                        groupValue: svalue,
                        onChanged: (int value) {
                          setState(() {
                            svalue = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Draw'),
                      leading: Radio(
                        value: 5,
                        groupValue: svalue,
                        onChanged: (int value) {
                          setState(() {
                            svalue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: ShowElement1 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Container(
                      child: Text('The team that Scored first:'),
                      margin: EdgeInsets.only(top: 40, bottom: 40),
                    ),
                    ListTile(
                      title: Text(str1),
                      leading: Radio(
                        value: 6,
                        groupValue: svalue2,
                        onChanged: (int value) {
                          setState(() {
                            svalue2 = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(str2),
                      leading: Radio(
                        value: 4,
                        groupValue: svalue2,
                        onChanged: (int value) {
                          setState(() {
                            svalue2 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              BlocBuilder<BookieBloc,BookieState>(
                builder:(context,state){
                  return RaisedButton(
                      onPressed: () {

                        BlocProvider.of<BookieBloc>(context).add(BookieBetLoad());
                        if(state is BookieLoadSuccess ){
                          bookies=state.bets;
                          for(int i=0; i< bookies.length;i++){
                            if(bookies[i].gameID==game.id){
                              ubookie=bookies[i];
                            }
                          }

                          if (ShowElement1) {
                            if ((svalue == null) || (svalue2 == null)) {
                              SnackBar sbar =
                              SnackBar(content: Text('Please enter all choice'));
                              skey.currentState.showSnackBar(sbar);
                            } else {
                              vals = [svalue, svalue2];
                              if (vals[0] == 1) {
                                setState(() {
                                  builderFlag=true;
                                  ubookie.outcome= 0;
                                });

                              } else if (vals[0] == 2) {
                                setState(() {
                                  builderFlag=true;
                                  ubookie.outcome = 1;
                                });

                               // print('b');
                              } else if (vals[0] == 5) {
                                setState(() {
                                  builderFlag=true;
                                  ubookie.outcome = 2;
                                });

                                print('c');
                              }

                              if (vals[1] == 6) {
                                setState(() {
                                  builderFlag=true;
                                  ubookie.outcome = 3;
                                });

                                print(ubookie.outcome);
                                print('d');
                              } else if (vals[1] == 4) {
                                setState(() {
                                  builderFlag=true;
                                  ubookie.outcome = 4;
                                });

                                print('e');
                              } else if (vals[1] == 7) {
                                setState(() {
                                  builderFlag=true;
                                  ubookie.outcome = 5;
                                });


                                print('f');}

                            }
                          }






                        }

                      },
                      child: Text('Submit'));
                } ,

              ),

              builderFlag ? BlocBuilder<BookieBloc,BookieState>(builder: (context,state){
               print('12344544353');
                BlocProvider.of<BookieBloc>(context).add(BookieBetUpdate(ubookie));
                if(state is BookieLoadSuccess){
                  //print(state.bets);
                  Navigator.pop(context, vals);
                }
                else{
                 // print('dfjhfjdjfdka');
                  SnackBar sbar2 =
                  SnackBar(content: Text('Problem in Updating bet'));
                  skey.currentState.showSnackBar(sbar2);
                }
              return ;
              }): Text('djndsjnjasdjn')
            ],
          ),
        ),
      ),
    );
  }
}
