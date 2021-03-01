import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adminBudgetMaintain.dart';

class Users {
  String name;
  String balance;
  Users({this.name, this.balance});
}

class AdminBudgetList extends StatelessWidget {



  final List<Users> usersList = [
    Users(name: 'Natnael', balance: '900.0'),
    Users(name: 'Dagmawi', balance: '1000.0'),
    Users(name: 'Samuel', balance: '4500.0'),
    Users(name: 'Abel', balance: '200.0'),
    Users(name: 'Yosef', balance: '150.0')
  ];
  Card makeCard(int index, Function tap) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(45, 114, 178, 0.7).withOpacity(0.7)),
        child: makeListTile(index, tap),
      ),
    );
  }

  ListTile makeListTile(int index, Function tap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

      title: Text(
        usersList[index].name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Text(usersList[index].balance, style: TextStyle(color: Colors.white))
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
    final Users user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text("Users' list"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          Function tap = () => Navigator.pushNamed(context, '/userList',
              arguments: usersList[index]);
          return makeCard(index, tap);
        },
      ),
    );
  }
}