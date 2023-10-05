import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    // ChatUser => Map<String, dynamic>
    final docRef = await store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageUrl,
    });

    // Map<String, dynamic> => ChatUser
    final documentSnapshot = await docRef.get();

    final data = documentSnapshot.data()!;

    return ChatMessage(
      id: documentSnapshot.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageUrl'],
    );
  }
}
