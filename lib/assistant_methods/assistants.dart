import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../models/user_model.dart';

class AssistantMethod{
  static void readCurrentOnlinePassengerInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users").child(currentFirebaseUser!.uid);

    Reference storageRef = FirebaseStorage.instance.ref().child("userImages").child('${currentFirebaseUser!.uid}.jpg');

    String downloadUrl = await storageRef.getDownloadURL();

    profileImageUrl = downloadUrl;

    userRef.once().then((snap)
    {
      if(snap.snapshot.value != null)
      {
        userModelCurrentInfo = UserModel.fromSnapShot(snap.snapshot);
      }
    });

  }


}