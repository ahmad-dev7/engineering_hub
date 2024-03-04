import 'package:flutter/material.dart';

class KMessageTextField extends StatefulWidget {
  const KMessageTextField(
      {super.key,
      required this.focusNode,
      required this.messageController,
      required this.onSend});
  final FocusNode focusNode;
  final Function() onSend;
  final TextEditingController messageController;

  @override
  State<KMessageTextField> createState() => _KMessageTextFieldState();
}

class _KMessageTextFieldState extends State<KMessageTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 0),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.messageController,
        maxLines: 5,
        minLines: 1,
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        onChanged: (value) => setState(() {}),
        decoration: InputDecoration(
          filled: true,
          hintText: 'Type your message...',
          hintStyle: TextStyle(
            color: Theme.of(context).hoverColor.withAlpha(100),
          ),
          fillColor: Theme.of(context).colorScheme.background.withAlpha(200),
          suffixIcon: IconButton(
            splashColor: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                widget.onSend();
                widget.messageController.clear();
              });
            },
            icon: Icon(
              Icons.send,
              color: widget.messageController.text.isEmpty
                  ? Theme.of(context).hoverColor
                  : Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withGreen(120),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).hoverColor,
            ),
          ),
        ),
      ),
    );
  }
}
