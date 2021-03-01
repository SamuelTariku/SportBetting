import 'package:flutter/material.dart';

class AdminBudgetMaintain extends StatefulWidget{
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<AdminBudgetMaintain>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintain Budgets"),
      ),
      body: Container(
        child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 130.0, top: 75, bottom: 10),
                    child: Text("Natnael", style: TextStyle(fontSize: 32),), //get name from route
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130.0, top: 40, bottom: 80),
                    child: Text("Current Balance: 900"), // get balance from route
                  ),
                  Container(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Input amount',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150.0, top: 15,),
                    child: RaisedButton(
                        child: Text("Increase"),
                        onPressed: (){
                          //function to add money to the user's balance from rest
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150.0, top: 15,),
                    child: RaisedButton(
                        child: Text("Decrease"),
                        onPressed: (){
                          //function to subtract money from the user's balance from rest
                        }
                    ),
                  )
                ],
              ),
             ),
      ),
    );
  }
}