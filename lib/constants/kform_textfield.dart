import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KFormTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextCapitalization? capitalization;
  final Function(String) validator;
  final bool Function(String)? errorIndicator;
  final bool? password;
  final Widget? suffixIcon;

  const KFormTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.controller,
    required this.prefixIcon,
    required this.validator,
    this.errorIndicator,
    this.password,
    this.suffixIcon,
    this.capitalization,
  });

  @override
  State<KFormTextField> createState() => _KFormTextFieldState();
}

class _KFormTextFieldState extends State<KFormTextField> {
  IconData wrongIcon = FontAwesomeIcons.circleXmark;
  IconData rightIcon = FontAwesomeIcons.circleCheck;
  IconData iconData = Icons.circle;
  late Color iconColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      controller: widget.controller,
      keyboardType: widget.inputType,
      textCapitalization: TextCapitalization.words,
      obscureText: widget.password ?? false,
      onChanged: (value) {
        if (widget.errorIndicator!(value)) {
          setState(() {
            iconData = rightIcon;
            iconColor = const Color(0xFF63D967);
          });
        } else if (value.isNotEmpty) {
          setState(() {
            iconData = wrongIcon;
            iconColor = const Color(0xFFFFE605);
          });
        } else {
          setState(() {
            iconData = Icons.circle;
            iconColor = Theme.of(context).primaryColor;
          });
        }
      },
      validator: (value) => widget.validator(value.toString()),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.35)),
        prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: Theme.of(context).iconTheme.color,
        suffixIcon: widget.suffixIcon ??
            Icon(iconData,
                color: widget.controller.text.isEmpty
                    ? Theme.of(context).primaryColor
                    : iconColor),
        suffixIconColor: Theme.of(context).primaryColor,
        focusColor: const Color(0xFF68A89D),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              width: 0.01,
              color: Theme.of(context).colorScheme.primaryContainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              width: 0.2, color: Theme.of(context).colorScheme.onBackground),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
