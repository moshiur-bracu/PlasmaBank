import 'package:PlasmaBank/screens/Receiver/receiver_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/services/database_receiver.dart';
import 'package:PlasmaBank/shared/loading.dart';

class ReceiverForm extends StatefulWidget {
  @override
  _ReceiverFormState createState() => _ReceiverFormState();
}

class _ReceiverFormState extends State<ReceiverForm> {
  
  final _formKey = GlobalKey<FormState>();

  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> cities = ['Dhaka', 'Sylhet', 'Chittagong', 'Rajshahi', 'Khulna', 'Barishal', 'Rangpur'];
  bool loading = false;

  // form values
  String _currentId;
  String _currentName;
  String _currentContactNumber;
  String _currentBloodGroup;
  String _currentCity;
  String _currentAccepted;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('PlasmaBank'),
        centerTitle: false,
      ),
          body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Create a new request',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Name'),
              validator: (val) => val.isEmpty ? 'Name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Contact Number'),
              validator: (val) => val.isEmpty ? 'Contact Number' : null,
              onChanged: (val) => setState(() => _currentContactNumber = val),
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField(
              value: _currentBloodGroup ?? 'A+',
              decoration: textInputDecoration,
              items: bloodGroups.map((bloodGroup) {
                return DropdownMenuItem(
                  value: bloodGroup,
                  child: Text('$bloodGroup'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentBloodGroup = val ),
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField(
              value: _currentCity ?? 'Dhaka',
              decoration: textInputDecoration,
              items: cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text('$city'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentCity = val ),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if(_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _currentAccepted = 'false';
                  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  _currentId = user.uid;
                  await ReceiverDatabaseService(uid: user.uid).updateUserData(
                  _currentId,
                  _currentName,
                  _currentContactNumber,
                  _currentBloodGroup,
                  _currentCity,
                  _currentAccepted,
                    );
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceiverHome()),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}