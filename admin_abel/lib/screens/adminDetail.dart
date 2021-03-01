import 'package:admin_abel/models/fixture.dart';
import 'package:flutter/material.dart';
import 'adminList.dart';

class AdminDetail extends StatelessWidget {
  int val;
  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Fixture game = ModalRoute.of(context).settings.arguments;
    //var teams = game.title.split(" ");
    String str1=game.teamOne;
    String str;
    String str3;
    String str2=game.teamTwo;

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Delete Game"),
            content: new Text("Are you sure you want to delete game?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  //function to delete the game from rest and return to games list
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    return Scaffold(
      key: skey,
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              '$str1 VS $str2',
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
            Text(
              game.time,
              style: TextStyle(fontSize: 20),
            ),
            Text(' ',
                style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic)),
            Divider(
              color: Colors.black,
            ),
            Text('What do you want to do?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        var val = await Navigator.pushNamed(context, '/update',
                            arguments: game);
                        List<int> val2 = val;
                       // print(val2[0]);
                        //print(val2[1]);
                        if (val2[0] == 1) {
                          str = str1;
                        } else if (val2[0] == 2) {
                          str = str2;
                        } else if (val2[0] == 5) {
                          str = 'draw selected';
                        }
                       // print(str);

                        if (val2[1] == 6) {
                          str3 = str;
                        } else if (val2[1] == 4) {
                          str3 = str2;
                        } else if (val2[1] == 7) {
                          str3 = 'draw selected';
                        }

                        SnackBar bar = SnackBar(
                          content: Text('$str $str3 selected'),
                        );
                        skey.currentState.showSnackBar(bar);
                        //print(str2);
                      },
                      child: Text('Update Game'),
                      color: Colors.blue,

                    ),
                    RaisedButton(
                      child: Text('Delete Game'),
                      color: Colors.blue,
                      onPressed: _showDialog
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}