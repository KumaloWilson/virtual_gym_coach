import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';
import 'package:virtual_gym_coach/widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({required this.hintText, required this.icon, required this.onChanged});

  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none
        ),
      )
    );
  }
}
