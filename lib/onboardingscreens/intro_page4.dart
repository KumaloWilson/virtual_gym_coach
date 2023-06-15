import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';


class IntroPage4 extends StatelessWidget {
  const IntroPage4({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/onboarding4.jpg'),
            fit: BoxFit.fitHeight
        ),
        color: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.65,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
        ),
        child: Text(
            "Let our Gym Genie be your trusted companion on your fitness journey. Get ready to experience personalized workouts, expert guidance, and a supportive community. Let's achieve your fitness goals together!",
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
