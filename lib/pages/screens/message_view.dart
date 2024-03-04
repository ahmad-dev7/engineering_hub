import 'package:engineering_hub/backend/api_calls.dart';
import 'package:engineering_hub/backend/local_storage.dart';
import 'package:engineering_hub/constants/kfunctions.dart';
import 'package:engineering_hub/constants/kmenu_item_list.dart';
import 'package:engineering_hub/constants/kmessagebubble.dart';
import 'package:engineering_hub/constants/kmessagefield.dart';
import 'package:engineering_hub/constants/kstream_builder.dart';
import 'package:engineering_hub/constants/kstyledtext.dart';
import 'package:engineering_hub/model/message_model.dart';
import 'package:engineering_hub/model/student.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';

class MessageBuilder extends StatefulWidget {
  const MessageBuilder({super.key});

  @override
  State<MessageBuilder> createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  FocusNode focusNode = FocusNode();
  TextEditingController messageController = TextEditingController();
  Student user = LocalStorage().readStudentData();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: KStreamBuilder(
            receivedMessageList: (messageList) {
              return ListView.builder(
                reverse: true,
                controller: ScrollController(),
                addAutomaticKeepAlives: true,
                itemCount: messageList.length,
                itemBuilder: (BuildContext context, int i) {
                  Message msg = messageList[i];
                  bool thisUser = msg.senderId == user.userId;
                  String date = getDate(msg.dateTime);
                  bool isToday =
                      getDate(DateTime.now().toString()) == getDate(date);
                  return Column(
                    crossAxisAlignment: thisUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      //* Date card
                      Visibility(
                        visible: (i == messageList.length - 1 ||
                            getDate(msg.dateTime) !=
                                getDate(messageList[i + 1].dateTime)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 25),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(isToday ? 'Today' : date),
                            ),
                          ),
                        ),
                      ),
                      //* Message with name and date
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: i == 0 ? 15 : 0,
                        ),
                        margin: thisUser
                            ? const EdgeInsets.only(left: 60)
                            : const EdgeInsets.only(right: 60),
                        child: Column(
                          crossAxisAlignment: thisUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            //* Name card
                            Visibility(
                              visible: i == messageList.length - 1 ||
                                  msg.senderId != messageList[i + 1].senderId ||
                                  getDate(msg.dateTime) !=
                                      getDate(messageList[i + 1].dateTime),
                              child: styledText(
                                text: msg.senderName,
                                size: 14,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            //* Message bubble
                            FocusedMenuHolder(
                              onPressed: () {},
                              menuWidth: MediaQuery.of(context).size.width / 2,
                              menuBoxDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                              ),
                              menuItems: kMenuItem(
                                thisUser,
                                context,
                                msg,
                                () {
                                  messageController.text = msg.message;
                                  edit = true;
                                  messageId = msg.messageId;
                                  FocusScope.of(context)
                                      .requestFocus(focusNode);
                                },
                              ),
                              child: KMessageBubble(
                                thisUser: thisUser,
                                child: Column(
                                  crossAxisAlignment: thisUser
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    styledText(
                                      text: msg.message,
                                      size: 15,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                    const SizedBox(width: 10),
                                    //! date here
                                    styledText(
                                      text: getTime(msg.dateTime),
                                      size: 10,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        KMessageTextField(
          focusNode: focusNode,
          onSend: sendMessage,
          messageController: messageController,
        ),
      ],
    );
  }

  bool edit = false;
  String? messageId = '';
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      if (edit == true && messageId != '') {
        debugPrint('Editing ID:  $messageId');
        debugPrint('Editing message:  ${messageController.text}');
        Api().updateMessage(
          newMessage: messageController.text,
          messageId: messageId,
        );
        edit = false;
        messageId = '';
      } else {
        Api().writeMessage(message: messageController.text);
      }
      //Api().writeMessage(message: messageController.text);
    }
  }
}
