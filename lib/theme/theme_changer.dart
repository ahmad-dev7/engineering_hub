import 'package:engineering_hub/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChangerWidget extends StatelessWidget {
  const ThemeChangerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        height: 40,
        width: 50,
        child: Switch.adaptive(
          value: themeProvider.isDarkMode,
          splashRadius: 4,
          activeColor: Colors.blueGrey[700],
          activeThumbImage: const AssetImage('images/moon.png'),
          inactiveThumbImage: const AssetImage('images/sun.png'),
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),
      ),
    );
  }
}
