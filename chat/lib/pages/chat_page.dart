import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          actions: [
            DropdownButton(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              underline: Text(''),
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
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ));
  }
}
