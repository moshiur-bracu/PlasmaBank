import 'package:PlasmaBank/screens/Receiver/receiver_home.dart';
import 'package:PlasmaBank/screens/Receiver/receiver_user.dart';
import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/services/database_receiver.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:PlasmaBank/services/receiver_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

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
  String _currentBloodGroup = 'A+';
  String _currentCity = 'Dhaka';
  String _currentAccepted;

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';


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
        elevation: 0,
        title: Text('PlasmaBank'),
        centerTitle: false,
      ),
          body: WillPopScope(
            onWillPop: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
          return Future.value(false);
            },
                      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                    maxLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val.isEmpty ? 'Name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.number,
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
                  ListTile(
                  title: Text('Upload Image of Corona Positive Certificate', style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.image, color: Colors.white,),
                  onTap: () {
                    setState(() {
                      fileType = 'image';
                    });
                  filePicker(context);
                  },
                  ),
              SizedBox(height: 10.0),
                  SizedBox(
                    width: 300,
                    height: 40,
                                      child: RaisedButton(
                      elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                      color: kSecondaryColor,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final ReceiverAuthService _auth = ReceiverAuthService();
                          dynamic result = await _auth.signInAnon();
                          if(result == null) {
                            setState(() {
                              loading = false;
                            });
                            print('Error Signinig In');
                          }
                          else {
                            print('Signed In');
                            print(result.uid);
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

                          
                          StorageReference storageReference;
                          if (fileType == 'image') {
                          storageReference = 
                          FirebaseStorage.instance.ref().child("images/Receivers/$_currentId/$fileName");
                          }
                          final StorageUploadTask uploadTask = storageReference.putFile(file);
                          final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                          final String url = (await downloadUrl.ref.getDownloadURL());
                          print("URL is $url");
                          

                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReceiverHome()),
                          );
                        }
                          
                        }
                      }
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
          ),
    
    );
  }
}