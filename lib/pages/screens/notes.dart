import 'package:engineering_hub/constants/ksnackbar.dart';
import 'package:engineering_hub/constants/kStyledText.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool thisUser = true;
  void onChatbotTap() => KSnackBar('Not implemented yet').failed();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: StyledText(
          text: 'Notes',
          color: Theme.of(context).colorScheme.onBackground,
        ),
        centerTitle: true,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: InkWell(
        onTap: onChatbotTap,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: const Color(0xFF536D7B),
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 20,
                offset: Offset(0, 20),
                spreadRadius: 2,
              )
            ],
          ),
          child: Image.asset('images/chat_bot.png'),
        ),
      ),
      body: Center(
        child: InkWell(
          splashColor: Theme.of(context).scaffoldBackgroundColor,
          onTap: () {
            setState(() {
              thisUser = !thisUser;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: thisUser
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        offset: const Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
