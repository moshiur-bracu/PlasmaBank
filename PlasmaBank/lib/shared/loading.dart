import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Center(
        child: SpinKitWanderingCubes(
          color: kSecondaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}