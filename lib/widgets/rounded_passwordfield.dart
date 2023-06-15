import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';
import 'package:virtual_gym_coach/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

bool obscureText = false;

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: !obscureText,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(
              obscureText
              ?Icons.visibility
                  :Icons.visibility_off,
              color: primaryColor,
            )

          ),
          border: InputBorder.none
        ),
      )
    );
  }
}
