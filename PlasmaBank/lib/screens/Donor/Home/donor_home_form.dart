import 'package:PlasmaBank/screens/Donor/Home/donor_home_profile_after.dart';
import 'package:PlasmaBank/services/database_donor.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;


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

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  String _currentId;


  // text field state
  String name = 'name';
  String email = 'email';
  String contactNumber = 'contactNumber';
  String city = 'Dhaka';
  String bloodGroup = "A+";
  String positiveDate = 'positiveDate';
  String negativeDate = 'negativeDate';
  String donationTimes = 'donationTimes';
  String lastDonation = 'lastDonation';
  String newSymptoms = 'newSymptoms';
  String viralDiseases = 'viralDsiseases';
  String pregnancyOrAbortion = 'pregnancyOrAbortion';
  String approval = 'notApproved';

  @override
  Widget build(BuildContext context) {

    Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
      }
    } on PlatformException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        );
    }
  }

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
                  decoration: textInputDecoration.copyWith(hintText: 'Number of previous Donations'),
                  //validator: (val) => val.isEmpty ? 'Viral Diseases' : null,
                  onChanged: (valDOn) {
                    setState(() => donationTimes = valDOn);
                  },
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
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'New Symmptoms'),
                  //validator: (val) => val.isEmpty ? 'Viral Diseases' : null,
                  onChanged: (valSym) {
                    setState(() => newSymptoms = valSym);
                  },
                ),
                SizedBox(height: 20.0),
                ListTile(
                  title: Text('Upload Image of Corona Negative Certificate', style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.image, color: Colors.white,),
                  onTap: () {
                    setState(() {
                      fileType = 'image';
                    });
                  filePicker(context);
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
                  _currentId = user.uid;
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
                  approval
                    );

                   StorageReference storageReference;
                        if (fileType == 'image') {
                        storageReference = 
                        FirebaseStorage.instance.ref().child("images/Donors/$_currentId/$fileName");
                        }
                        final StorageUploadTask uploadTask = storageReference.putFile(file);
                        final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                        final String url = (await downloadUrl.ref.getDownloadURL());
                        print("URL is $url");
                        
                        

                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorHomeProfileAfter()),
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