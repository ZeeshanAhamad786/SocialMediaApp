import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfilEdit_Controller extends GetxController {
  var name = ''.obs;
  var dateOfBirth = ''.obs;
  var location = ''.obs;
  var bio = ''.obs;

  void fetchData() async {
    try {
      // Replace 'your_user_id' with the actual user ID.
      // Assume you have initialized Firestore elsewhere in your app.
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('gFgJ5m3GoaPpZiB9bKW5VEe8Kdf1')
          .get();

      if (userDoc.exists) {
        name.value = userDoc['name'];
        dateOfBirth.value = userDoc['dob'];
        location.value = userDoc['location'];
        bio.value = userDoc['bio'];
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void updateUserData() async {
    final docId = 'gFgJ5m3GoaPpZiB9bKW5VEe8Kdf1';

    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(docId).get();

      if (userDoc.exists) {
        await FirebaseFirestore.instance.collection('users').doc(docId).update({
          'name': name.value,
          'date_of_birth': dateOfBirth.value,
          'location': location.value,
          'bio': bio.value,
        });

        print('User data updated successfully');
      } else {
        print('Document with ID $docId does not exist');
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

}
