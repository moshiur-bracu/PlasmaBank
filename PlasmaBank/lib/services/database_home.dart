import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHome {
 
    Map<String, dynamic> coronaUpdates = {};

    Future<Null> getCoronaUpdate() async {
    await Firestore.instance
        .collection('Home') // Your Collections Name
        .document('Corona Updates')  // Your user Document Name
        .get().then((val) {
      coronaUpdates.addAll(val.data);

      return coronaUpdates;
    }
    
    );
  }

}

