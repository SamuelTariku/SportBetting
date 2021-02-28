import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = 'userEdit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 120, left: 20, right: 20),
          color: Color.fromRGBO(125, 125, 125, 0.1),
          width: double.infinity,
          child: Column(children: [
            Text('Hey! UserName', style: Theme.of(context).textTheme.headline4),
            UserTextField('User Name', false),
            UserTextField('Email', false),
            UserTextField('Password', true),
            UserTextField('Confirm Password', true),
            FlatButton(
                height: 50,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  // side: BorderSide(color: Colors.red)
                ),
                onPressed: () {},
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('Submit Changes'))
          ]),
        ),
      ),
    );
  }
}
