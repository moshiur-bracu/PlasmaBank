import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class DonorRequestBefore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'You are not authorized to view this page. Please go to Profile Page to create e new donor.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}