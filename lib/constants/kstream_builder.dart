import 'package:engineering_hub/constants/kfunctions.dart';
import 'package:engineering_hub/constants/kstyledtext.dart';
import 'package:engineering_hub/model/message_model.dart';
import 'package:flutter/material.dart';

class KStreamBuilder extends StatefulWidget {
  final Function(List<Message>) receivedMessageList;
  const KStreamBuilder({super.key, required this.receivedMessageList});

  @override
  State<KStreamBuilder> createState() => _KStreamBuilderState();
}

class _KStreamBuilderState extends State<KStreamBuilder> {
  late List<Message> messageList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamOfMessages(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              color: Theme.of(context).progressIndicatorTheme.color,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: styledText(text: 'Failed to load message.'),
          );
        }
        if (snapshot.hasData) {
          messageList = snapshot.data;
          messageList = messageList.reversed.toList();
          if (messageList.isEmpty) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: styledText(
                text:
                    'No message found in this group.\nBe the first one to send message here.',
                size: 16,
                color: Theme.of(context).hintColor,
              ),
            );
          } else {
            return widget.receivedMessageList(messageList);
          }
        }
        return styledText(
          text: 'Something unexpected happened',
          size: 16,
        );
      },
    );
  }
}
