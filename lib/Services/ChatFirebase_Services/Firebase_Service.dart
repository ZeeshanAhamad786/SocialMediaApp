// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
//

//
// class FirebaseService {
//   final CollectionReference messagesCollection =
//   FirebaseFirestore.instance.collection('messages');
//
//   Future<void> sendMessage(String senderId, String receiverId, String content) async {
//     // Create a new message document in the 'messages' collection
//     await FirebaseFirestore.instance.collection('messages').add({
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'content': content,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
//
//
//   Stream<List<Message>> getMessageStream(String userId) {
//     return FirebaseFirestore.instance
//         .collection('messages')
//         .where('senderId', isEqualTo: userId)
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       List<Message> messages = [];
//       for (var doc in snapshot.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         messages.add(Message(
//           id: doc.id,
//           senderId: data['senderId'],
//           receiverId: data['receiverId'],
//           content: data['content'],
//           timestamp: data['timestamp'].toDate(),
//         ));
//       }
//       return messages;
//     })
//         .handleError((error) {
//       // Handle any errors here, for example, log the error
//       print('Error occurred: $error');
//       // Return an empty list in case of error
//       return [];
//     });
//   }
//
//
// }