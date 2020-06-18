import 'package:PlasmaBank/screens/Donor/Home/donor_home_form.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class DonorFormHomeBefore extends StatefulWidget {
  @override
  _DonorFormHomeBeforeState createState() => _DonorFormHomeBeforeState();
}

class _DonorFormHomeBeforeState extends State<DonorFormHomeBefore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Center(
        child: RaisedButton(
          color: kSecondaryColor,
          child: Text(
            'Create New Donor',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorForm()),
                  );
          },
        ),
        ),
    );
  }
}