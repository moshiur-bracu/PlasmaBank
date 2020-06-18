import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/services/receiver_auth.dart';

class ReceiverHome extends StatelessWidget {

  final ReceiverAuthService _auth = ReceiverAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text('Home'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Text('Your request has been accepted. Now wait for a donor to get back to you soon',
              style: TextStyle(
                color: Colors.white,
              ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Sign Out'),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper()),
                  );
                },
              ),
            ],
          ),
          
        ),
    );
  }
}