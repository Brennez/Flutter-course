import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatUser? currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Sem mensagens por enquanto, vamos conversar? ',
              textAlign: TextAlign.center,
            ),
          );
        } else {
          final messages = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageBubble(
                  key: ValueKey(messages[index].id),
                  message: messages[index],
                  belongsToCurrentUser:
                      currentUser?.id == messages[index].userId);
            },
          );
        }
      },
    );
  }
}
