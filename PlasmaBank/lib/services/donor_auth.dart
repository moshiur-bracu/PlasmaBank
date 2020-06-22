import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:PlasmaBank/services/database_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonorAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  DonorUser _donorUserFromFirebaseUser(FirebaseUser user) {
    return user != null ? DonorUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<DonorUser> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_donorUserFromFirebaseUser);
  }

  //get database instance
  Future getDatabaseInstance(String uid) async{

    try { final value = await Firestore.instance.collection('Donor Lists').document(uid).get();
    //print(value.data);
    return value.data;
    } catch (error) {
      print(error.toString());
      return null;
    }
    
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DonorDatabaseService(uid: user.uid).updateUserData('name', 'email', 'contactNumber', 'city', 
      'bloodGroup', 'positiveDate', 'negativeDate', 'donationTimes', 'lastDonation', 
      'newSymptoms', 'viralDiseases', 'pregnacyOrAbortion', 'notApproved');

      return _donorUserFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}