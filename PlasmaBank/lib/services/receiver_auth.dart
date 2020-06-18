import 'package:PlasmaBank/screens/Receiver/receiver_user.dart';
import 'package:PlasmaBank/services/database_receiver.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReceiverAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create reciever user object based on FirebaseUser
  ReceiverUser _receiverUserFromFirebaseUser(FirebaseUser user) {
    return user != null ? ReceiverUser(uid: user.uid) : null;
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      await ReceiverDatabaseService(uid: user.uid).updateUserData('id', 'name', 'contactNumber', 'bloodGroup', 'city', 'false');

      return _receiverUserFromFirebaseUser(user);
    } 
    catch(e) {
      print(e.toString());
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