import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class DonorFormHomeAfter extends StatefulWidget {
  @override
  _DonorFormHomeAfterState createState() => _DonorFormHomeAfterState();
}

class _DonorFormHomeAfterState extends State<DonorFormHomeAfter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text(
          'Data has been saved!',
          style: TextStyle(
            color: Colors.white,
          ),
          ),
      ),
    );
  }
}