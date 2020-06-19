import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryColor,
        //automaticallyImplyLeading: false,
        title: Text('PlasmaBank Home'),
      ),
    );
  }
}