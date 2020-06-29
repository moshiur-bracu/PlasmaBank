import 'package:PlasmaBank/screens/Donor/Home/donor_home_form.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class DonorHomeProfileBefore extends StatefulWidget {
  @override
  _DonorHomeProfileBeforeState createState() => _DonorHomeProfileBeforeState();
}

class _DonorHomeProfileBeforeState extends State<DonorHomeProfileBefore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Center(
        child: 
        ButtonTheme(
              minWidth: 200.0,
              height: 45.0,
              buttonColor: kSecondaryColor,
                          child: RaisedButton(
                            elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorForm()),
                  );
          },
                child: Text(
                  'Create a Donor Account',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
            ),
        ),
    );
  }
}