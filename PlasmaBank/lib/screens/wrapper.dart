import 'package:PlasmaBank/screens/Receiver/receiver_form.dart';
import 'package:PlasmaBank/screens/Home/home.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/screens/Donor/donor_provider.dart';
import 'package:PlasmaBank/services/receiver_auth.dart';
import 'package:PlasmaBank/shared/loading.dart';

class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  
  bool loading = false;
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: loading ? Loading() : Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 200.0,
              height: 45.0,
              buttonColor: kSecondaryColor,
                          child: RaisedButton(
                            elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonorProvider()),
                    );
                },
                child: Text(
                  'DONATE PLASMA',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
            ),
SizedBox(height: 10.0,),
            ButtonTheme(
              minWidth: 200.0,
              height: 45.0,
              buttonColor: kSecondaryColor,
                          child: RaisedButton(
                            elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () async {
                  setState(() {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReceiverForm()),
                  );

                  });
                  
                },
                child: Text(
                  'NEED PLASMA',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
            ),
SizedBox(height: 10.0,),
            ButtonTheme(
              minWidth: 200.0,
              height: 45.0,
              buttonColor: kSecondaryColor,
                          child: RaisedButton(
                            elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                },
                child: Text(
                  'BROWSE HOME',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
            ),


          ],
        ),
      ),
    ),
    );
  }
}