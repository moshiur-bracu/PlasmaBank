import 'package:PlasmaBank/screens/Donor/Home/donor_form_home_after.dart';
import 'package:PlasmaBank/services/database_donor.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';


class DonorForm extends StatefulWidget {

  @override
  _DonorFormState createState() => _DonorFormState();
}

class _DonorFormState extends State<DonorForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> cities = ['Dhaka', 'Sylhet', 'Chittagong', 'Rajshahi', 'Khulna', 'Barishal', 'Rangpur'];

  final format = DateFormat("yyyy-MM-dd");
  DateTime datePositive;
  DateTime dateNegative;
  DateTime lastDon;

  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String contactNumber = '';
  String city;
  String bloodGroup;
  String positiveDate = '';
  String negativeDate = '';
  String donationTimes = '';
  String lastDonation = '';
  String newSymptoms = '';
  String viralDiseases = '';
  String pregnancyOrAbortion = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Center(
                  child: Text(
            'Be a DONOR',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
                      child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (valN) => valN.isEmpty ? 'Enter your name' : null,
                  onChanged: (valN) {
                    setState(() => name = valN);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (valE) => valE.isEmpty ? 'Enter your email' : null,
                  onChanged: (valE) {
                    setState(() => email = valE);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Contact Number'),
                  validator: (valC) => valC.isEmpty ? 'Enter your number' : null,
                  onChanged: (valC) {
                    setState(() => contactNumber = valC);
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                value: city ?? 'Dhaka',
                decoration: textInputDecoration,
                items: cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text('$city'),
                  );
                }).toList(),
                onChanged: (valCi) => setState(() => city = valCi ),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField(
                value: bloodGroup ?? 'A+',
                decoration: textInputDecoration,
                items: bloodGroups.map((bloodGroup) {
                  return DropdownMenuItem(
                    value: bloodGroup,
                    child: Text('$bloodGroup'),
                  );
                }).toList(),
                onChanged: (valB) => setState(() => bloodGroup = valB ),
                ),
                SizedBox(height: 20.0),
                DateTimeField(
                  format: format,
                  decoration: textInputDecoration.copyWith(hintText: 'Date of became positive'),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
                  },
                  onChanged: (dtP) => setState(() => datePositive = dtP),
                ),
                SizedBox(height: 20.0),
                DateTimeField(
                  format: format,
                  decoration: textInputDecoration.copyWith(hintText: 'Date of became negative'),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
                  },
                  onChanged: (dtN) => setState(() => dateNegative = dtN),
                ),
                SizedBox(height: 20.0),
                DateTimeField(
                  format: format,
                  decoration: textInputDecoration.copyWith(hintText: 'Date of last donation'),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
                  },
                  onChanged: (dtD) => setState(() => lastDon = dtD),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Any Recent Viral Diseases'),
                  //validator: (val) => val.isEmpty ? 'Viral Diseases' : null,
                  onChanged: (valDis) {
                    setState(() => viralDiseases = valDis);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Pregnancy or abortion'),
                  //validator: (val) => val.isEmpty ? 'Viral Diseases' : null,
                  onChanged: (valPreg) {
                    setState(() => pregnancyOrAbortion = valPreg);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    positiveDate = datePositive.toString();
                    negativeDate = dateNegative.toString();
                    lastDonation = lastDon.toString();
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  await DonorDatabaseService(uid: user.uid).updateUserData(
                  name,
                  email,
                  contactNumber,
                  city,
                  bloodGroup,
                  positiveDate,
                  negativeDate,
                  donationTimes,
                  lastDonation,
                  newSymptoms,
                  viralDiseases,
                  pregnancyOrAbortion,
                    );
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorFormHomeAfter()),
                  );
                }
              }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}