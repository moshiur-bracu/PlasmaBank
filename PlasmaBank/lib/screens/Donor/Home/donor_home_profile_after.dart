import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class DonorHomeProfileAfter extends StatefulWidget {
  @override
  _DonorHomeProfileAfterState createState() => _DonorHomeProfileAfterState();
}

class _DonorHomeProfileAfterState extends State<DonorHomeProfileAfter> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'We received your application. We will notify you soon when your account will be ready and you can start donating Plasma',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0
            ),
            ),
        ),
      ),
    );
  }
}