import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
          title: Text(
            'Minhas Notificações',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: service.itemCount,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index].title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              subtitle: Text(
                items[index].body,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              onTap: () {
                service.remove(index);
              },
            );
          },
        ));
  }
}
