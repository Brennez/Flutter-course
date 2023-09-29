import 'dart:async';
import 'dart:math';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Olá, bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Bia',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'bom dia, teremos uma call hoje?',
      createdAt: DateTime.now(),
      userId: '345',
      userName: 'Rebeca',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '1',
      text: 'Sim, pode entrar na call!',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Bia',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _messagesStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _messagesStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _messages.add(newMessage);

    _controller?.add(_messages.reversed.toList());

    return newMessage;
  }
}
