import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/userEdit';
  String username;
  String password;

  final UserTextField =
      (context, {label, obscure, validator, onSaved, controller}) => Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label),
            TextFormField(
              controller: controller,
              obscureText: obscure,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                focusColor: Theme.of(context).accentColor,
                border: OutlineInputBorder(),
              ),
              onSaved: onSaved,
              validator: validator,
            )
          ]));

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final TextEditingController _pass = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: BlocBuilder<LoginBloc, LoginState>(builder: (_, state) {
            if (state is LoginSuccess) {
              return Container(
                  padding: EdgeInsets.only(top: 120, left: 20, right: 20),
                  width: double.infinity,
                  child: Column(children: [
                    Text('User Profile: ${state.user.username}',
                        style: Theme.of(context).textTheme.headline4),
                    Text('Balance: ${state.user.balance}',
                        style: Theme.of(context).textTheme.headline4),
                    UserTextField(
                      context,
                      label: 'User Name',
                      obscure: false,
                      validator: (value) {
                        this.username = value;
                      },
                    ),
                    UserTextField(context,
                        label: 'Email',
                        obscure: false,
                        validator: (value) {},
                        onSaved: (value) {}),
                    UserTextField(context,
                        controller: _pass,
                        label: 'Password',
                        obscure: true,
                        validator: (value) {}, onSaved: (value) {
                      this.password = password;
                    }),
                    UserTextField(context,
                        label: 'Confirm Password',
                        obscure: true, validator: (value) {
                      if (_pass.text == value) {
                        return null;
                      } else {
                        return "Password doesn't match";
                      }
                    }, onSaved: (value) {
                      return null;
                    }),
                    FlatButton(
                        height: 50,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // side: BorderSide(color: Colors.red)
                        ),
                        onPressed: () {
                          bool vaild = _formkey.currentState.validate();
                          if (vaild == true) {
                            _formkey.currentState.save();
                            BlocProvider.of<UserBloc>(context)
                              ..add(UserUpdate(User(
                                  id: state.user.id,
                                  username: this.username,
                                  password: this.password)));
                          }
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('Submit Changes'))
                  ]));
            }
          }),
        ),
      ),
    );
  }
}
