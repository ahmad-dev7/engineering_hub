import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:engineering_hub/backend/local_storage.dart';
import 'package:engineering_hub/constants/kbutton.dart';
import 'package:engineering_hub/constants/kStyledText.dart';
import 'package:engineering_hub/theme/theme_changer.dart';
import 'package:engineering_hub/model/student.dart';
import 'package:engineering_hub/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Student studentData;
  @override
  initState() {
    setState(() {
      studentData = LocalStorage().readStudentData();
    });
    super.initState();
  }

  logout() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.question,
      title: 'Are you sure!',
      desc: 'You want to logout?',
      btnOkText: 'Logout',
      reverseBtnOrder: true,
      btnOkColor: Colors.red,
      btnCancelColor: Colors.blueGrey,
      dialogBackgroundColor: Theme.of(context).primaryColor,
      btnCancelText: 'Cancel',
      dialogBorderRadius: BorderRadius.circular(15),
      btnCancelOnPress: () => Get.back(),
      btnOkOnPress: () {
        LocalStorage().deleteStudentData();
        Get.offAll(() => const LoginPage());
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    String name = studentData.userName;
    String id = studentData.userId;
    debugPrint("$name entered the chat with id: $id");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: StyledText(
          text: "Welcome $name",
          color: Theme.of(context).colorScheme.onBackground,
        ),
        actions: const [ThemeChangerWidget()],
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: KActionButton(
          onTap: logout,
          width: double.maxFinite,
          color: Colors.red,
          text: 'Logout',
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: const Row(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.person, size: 40),
//                 ),
//                 SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Ahmad Ali',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text('8097746607'),
//                     Text('aali.dev7@gmail.com'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.update),
//                 label: const Text('Update Semester'),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.update),
//                 label: const Text('Update Branch'),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Your Products to Sell',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // Add your products list or grid here
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'You can help many students by providing BOOKS / NOTES PDF’s OR by providing YouTube videos / Playlists links which you refer for your studies.',
//               textAlign: TextAlign.center,
//             ),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.add),
//                 label: const Text('ADD PDF’s'),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.add_link),
//                 label: const Text('ADD Links'),
//               ),
//             ],
//           ),
//           const Spacer(),
//           ElevatedButton.icon(
//             onPressed: () {},
//             icon: const Icon(Icons.logout),
//             label: const Text('Logout'),
//           ),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
// }
