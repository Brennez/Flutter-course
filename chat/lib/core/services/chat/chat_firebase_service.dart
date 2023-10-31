import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import '../../services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;

    final snapshot = store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .snapshots();

    return Stream<List<ChatMessage>>.multi((controller) {
      snapshot.listen(
        (querySnapshot) {
          List<ChatMessage> messages = querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList();

          controller.add(messages);
        },
      );
    });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(msg);

    final documentSnapshot = await docRef.get();

    return documentSnapshot.data();
  }

  // Map<String, dynamic> => ChatMessage
  ChatMessage _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
    );
  }

  //  ChatMessage => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
      ChatMessage chatMessage, SetOptions? options) {
    return {
      'text': chatMessage.text,
      'createdAt': chatMessage.createdAt.toIso8601String(),
      'userId': chatMessage.userId,
      'userName': chatMessage.userName,
      'userImageUrl': chatMessage.userImageUrl,
    };
  }
}

// Implementação sem utilizar os conversores _toFirestore _fromFirestore
  // @override
  // Future<ChatMessage?> save(String text, ChatUser user) async {
  //   final store = FirebaseFirestore.instance;

  //   // ChatMessage => Map<String, dynamic>
  //   final docRef = await store.collection('chat').add({
  //     'text': text,
  //     'createdAt': DateTime.now().toIso8601String(),
  //     'userId': user.id,
  //     'userName': user.name,
  //     'userImageUrl': user.imageUrl,
  //   });

  //   // Map<String, dynamic> => ChatMessage
  //   final documentSnapshot = await docRef.get();

  //   final data = documentSnapshot.data()!;

  //   return ChatMessage(
  //     id: documentSnapshot.id,
  //     text: data['text'],
  //     createdAt: DateTime.parse(data['createdAt']),
  //     userId: data['userId'],
  //     userName: data['userName'],
  //     userImageUrl: data['userImageUrl'],
  //   );
  // }
