import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';


class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/onboarding1.jpg'),
            fit: BoxFit.fitHeight
        ),
        color: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.7,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
        ),
        child: Text(
            'Get ready to embark on a transformative fitness journey from the comfort of your own home. Gym Genie is here to guide and motivate you every step of the way.',

          style: TextStyle(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
