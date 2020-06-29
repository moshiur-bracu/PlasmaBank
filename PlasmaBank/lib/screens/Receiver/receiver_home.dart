import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/services/receiver_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReceiverHome extends StatelessWidget {

  final ReceiverAuthService _auth = ReceiverAuthService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
            onWillPop: () {
              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
          return Future.value(false);
            }, child: Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Your request has been accepted. Now wait for a donor to get back to you soon.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
                ),
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
              minWidth: 200.0,
              height: 45.0,
              buttonColor: kSecondaryColor,
                          child: RaisedButton(
                            elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () async {
                  Fluttertoast.showToast(msg: 'Request successful!');
                  await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper()),
                  );
                },
                child: Text(
                  'Complete your request',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
            ),
            ],
          ),
          
        ),
            )
    );
  }
}