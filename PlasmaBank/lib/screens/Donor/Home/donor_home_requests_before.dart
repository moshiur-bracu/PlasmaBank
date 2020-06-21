import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class DonorRequestBefore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text(
          'You are not authorized to view this page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}