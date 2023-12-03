import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/extensions/stream_sdk.dart';
import 'package:lets_buy/features/chat/chat_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessagesScreen extends StatefulWidget {
  static const String routeName = '/messages_screen';
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: ChannelListView(
        filter: Filter.in_('members', [context.currentUser!.id]),
        sort: const [SortOption('last_message_at')],
        pagination: const PaginationParams(
          limit: 20,
        ),
        channelWidget: const ChatScreen(),
      ),
    );
  }
}
