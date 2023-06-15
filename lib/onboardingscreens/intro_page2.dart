import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_gym_coach/global/global.dart';


class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/onboarding2.jpg'),
            fit: BoxFit.fitHeight
        ),
        color: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('workout_animations/gym-boy.json', height: MediaQuery.of(context).size.height * 0.4),
            Text(
              "Watch and learn as our virtual gym coach demonstrates each exercise with precision and proper form. You'll have access to a comprehensive library of exercises, ensuring you perform them correctly for maximum results and safety.",
              style: TextStyle(
                  color: textColor,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
