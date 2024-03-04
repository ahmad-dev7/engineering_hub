import 'package:engineering_hub/backend/local_storage.dart';
import 'package:engineering_hub/constants/ksliverappbar.dart';
import 'package:engineering_hub/model/student.dart';
import 'package:engineering_hub/packages/awesome_dialog.dart';
import 'package:engineering_hub/pages/screens/message_view.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String? selectedCollege, selectedBranch, selectedSemester;
  Student user = LocalStorage().readStudentData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //* It contains college, branch & semester dropdown with submit button
            KSliverAppBar(
              selectedCollege: selectedCollege,
              selectedBranch: selectedBranch,
              selectedSemester: selectedSemester,
              onCollegeSelect: (clg) => setState(() => selectedCollege = clg),
              onBranchSelect: (bran) => setState(() => selectedBranch = bran),
              onSemesterSelect: (sem) => setState(() => selectedSemester = sem),
              onSubmit: chatDestination,
            ),
          ];
        }),
        body: const MessageBuilder(),
      ),
    );
  }

  void chatDestination() {
    if (selectedCollege != null ||
        selectedBranch != null ||
        selectedSemester != null) {
    } else {
      awesomeDialog(
        context: context,
        description: 'You are already in the following chat',
      );
    }
  }
}
