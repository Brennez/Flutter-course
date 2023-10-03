import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/messages.dart';
import '../components/new_message.dart';
import '../core/services/auth/auth_service.dart';
import '../core/services/notification/chat_notification_service.dart';
import '../pages/notification_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    int notifications =
        Provider.of<ChatNotificationService>(context, listen: true).itemCount;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'My Chat',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        elevation: 4,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(top: 4),
          child: Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    notifications > 0
                        ? Icons.notifications
                        : Icons.notifications_none,
                    color: Colors.white,
                  )),
              if (notifications > 0)
                Positioned(
                  top: 5,
                  left: 22,
                  child: CircleAvatar(
                    maxRadius: 10,
                    backgroundColor: Colors.pinkAccent,
                    child: Text(
                      '$notifications',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sair',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Provider.of<ChatNotificationService>(context, listen: false).add(
      //         ChatNotification(
      //             title: 'Mais uma notificação!',
      //             body: Random().nextDouble().toString()),
      //       );
      //     },
      //     child: Icon(Icons.add)),
    );
  }
}
