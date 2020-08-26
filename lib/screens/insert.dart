import 'package:flutter/material.dart';

class Contribution extends StatefulWidget {
  @override
  _ContributionState createState() => _ContributionState();
}

class _ContributionState extends State<Contribution> {
  int no_of_months = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ADD DEPOSIT"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                onChanged: (String value) {
                  setState(() {
                    no_of_months = int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  labelText: "Number of months",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                scrollDirection: Axis.horizontal,
                
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  labelText: "Amount",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
