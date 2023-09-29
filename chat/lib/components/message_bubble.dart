import 'dart:io';

import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToCurrentUser,
  });

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;

    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(
        File(uri.toString()),
      );
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 10,
              ),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.deepPurple
                    : Color(0xff160e24),
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(12),
                  topLeft: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: belongsToCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 180,
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    belongsToCurrentUser ? 'você' : message.userName,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    message.text,
                    textAlign:
                        belongsToCurrentUser ? TextAlign.end : TextAlign.start,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 145,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageUrl),
        )
      ],
    );
  }
}
