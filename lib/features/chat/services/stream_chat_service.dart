import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/extensions/stream_sdk.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:lets_buy/features/chat/chat_screen.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class StreamChatService {
  Future<void> createChannel(BuildContext context, String userId) async {
    final core = StreamChatCore.of(context);
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        core.currentUser!.id,
        userId,
      ]
    });
    await channel.watch();

    Navigator.of(context).push(
      ChatScreen.routeWithChannel(channel),
    );
  }

  updateUser(UserModel user, BuildContext context) async {
    try {
      await StreamChatCore.of(context).client.updateUser(User(
          id: context.currentUser!.id, name: user.name, image: user.imgUrl));
    } catch (e) {
      print(e);
    }
  }
}
