import 'package:engineering_hub/backend/local_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:engineering_hub/pages/login.dart';
import 'package:engineering_hub/pages/navigation.dart';
import 'package:engineering_hub/theme/theme_data.dart';
import 'package:provider/provider.dart';

//* https://www.youtube.com/playlist?list=PLSOI1xClksi-GT-Nv8TWGxgDseTxTxa9U
//? To implement push notification and alerting user about new message watch this YouTube playlist

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('studentData');
  // Referencing local storage
  localStorage = Hive.box('studentData');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeDataProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeDataProvider>(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          title: 'Engineering HUB',
          home: localStorage.isNotEmpty
              // If user is already logged-in redirect to navigation page
              ? const BottomNavigationMenu()
              // If user isn't logged in show login screen
              : const LoginPage(),
        );
      },
    );
  }
}
